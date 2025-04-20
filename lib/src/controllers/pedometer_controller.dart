// controllers/pedometer_controller.dart
import 'dart:async';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class PedometerController extends GetxController {
  final FlutterBackgroundService _service = FlutterBackgroundService();
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  final RxInt steps = 0.obs;
  final RxDouble calories = 0.0.obs;
  final RxDouble distance = 0.0.obs;
  final double stepLength = 0.762; // Longitud promedio de paso en metros
  final double weight = 70.0; // Peso promedio en kg

  late StreamSubscription<StepCount>? _stepCountStream;
  int _initialSteps = 0;
  // final _service = FlutterBackgroundService();

  @override
  void onInit() {
    super.onInit();
    _initPedometer();
    _startBackgroundService();
    _loadSavedData();
  }
    // Método para inicializar el servicio
  Future<void> initializeService() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'pedometer_channel',
      'Podómetro',
      description: 'Canal para el podómetro en segundo plano',
      importance: Importance.low,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'pedometer_channel',
        initialNotificationTitle: 'Podómetro activo',
        initialNotificationContent: 'Contando tus pasos',
        foregroundServiceNotificationId: 1,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
    );

    if (await _service.isRunning()) {
      _service.startService();
    }
  }

  Future<void> _initPedometer() async {
    await Permission.activityRecognition.request();
    await Permission.sensors.request();

    _stepCountStream = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
    );
  }

  void _onStepCount(StepCount event) async {
    if (_initialSteps == 0) {
      _initialSteps = event.steps;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('initialSteps', _initialSteps);
    }

    final currentSteps = event.steps - _initialSteps;
    steps.value = currentSteps;
    _calculateMetrics();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', currentSteps);
  }

  void _onStepCountError(error) {
    print('Error en el podómetro: $error');
  }

  void _calculateMetrics() {
    distance.value = steps.value * stepLength;
    calories.value = steps.value * 0.04 * weight; // Fórmula simplificada
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    steps.value = prefs.getInt('steps') ?? 0;
    _initialSteps = prefs.getInt('initialSteps') ?? 0;
    _calculateMetrics();
  }

  Future<void> _startBackgroundService() async {
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'pedometer_channel',
        initialNotificationTitle: 'Podómetro activo',
        initialNotificationContent: 'Contando tus pasos',
        foregroundServiceNotificationId: 1,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
    );
    _service.startService();
  }

  @pragma('vm:entry-point')
  static void _onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    
    if (service is AndroidServiceInstance) {
      service.setAsForegroundService();
    }
    

    // Tu lógica de conteo de pasos aquí
    final prefs = await SharedPreferences.getInstance();
    int savedSteps = prefs.getInt('steps') ?? 0;
    int initialSteps = 0;
    bool isInitialized = false;

    late StreamSubscription<StepCount> stepSubscription;

    stepSubscription = Pedometer.stepCountStream.listen((StepCount event) async {
      if (!isInitialized) {
        initialSteps = event.steps;
        isInitialized = true;
      }

      final currentSteps = event.steps - initialSteps + savedSteps;
      await prefs.setInt('steps', currentSteps);

      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'Podómetro',
          content: 'Pasos: $currentSteps',
        );
      }
    });

    service.on('stopService').listen((_) {
      stepSubscription.cancel();
      service.stopSelf();
    });
  }

  @pragma('vm:entry-point')
  static Future<bool> _onIosBackground(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @override
  void onClose() {
    _stepCountStream?.cancel();
    super.onClose();
  }
}