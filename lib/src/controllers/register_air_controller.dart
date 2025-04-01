import 'dart:async';
import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/models/sun_models.dart';
import 'package:app_vida_saludable/src/providers/air_providers.dart';
import 'package:app_vida_saludable/src/providers/exercise_providers.dart';
import 'package:app_vida_saludable/src/providers/sun_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/air_models.dart';
import '../models/exercise_models.dart';
import '../models/user.dart';
import '../pages/register_habits/register_air_page.dart';

class RegisterAirController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  AirProviders airProviders = AirProviders();
  SunProviders sunProviders = SunProviders();
  ExerciseProviders exerciseProviders = ExerciseProviders();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late FlutterTts flutterTts;

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  // User user = User.fronJson(GetStorage().read('User') ?? {});
  HomeController airController = Get.find<HomeController>();
  var ejercicio = false.obs;
  var sol = false.obs;

  final List<String> tiposEjercicio = [
    'caminata lenta',
    'caminata rapida',
    'trote',
    'ejercicio guiado',
  ];

  var tipoEjercicioSeleccionado = ''.obs;

  bool _dialogShown = false;

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
    _initTextToSpeech();
    _updateDateTime();
  }

  Future<void> _initNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        if (!_dialogShown) {
          _showContinueDialog(Get.context!);
        }
      },
    );

    // Solicitar permiso para notificaciones
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  void _initTextToSpeech() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage("es-ES");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5);
  }

  Future<void> _updateDateTime() async {
    _currentDateTime.value = DateTime.now();
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: _currentDateTime.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.indigo,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      _currentDateTime.value = pickedDate;
      await selectTime();
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(_currentDateTime.value),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.indigo,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      final newDateTime = DateTime(
        _currentDateTime.value.year,
        _currentDateTime.value.month,
        _currentDateTime.value.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _currentDateTime.value = newDateTime;
    }
  }

  DateTime get currentDateTime => _currentDateTime.value;
  DateTime get endDateTime => currentDateTime.add(Duration(minutes: 45));

  void createAir() async {
    final storage = GetStorage();

    final userData = storage.read('User');

    if (userData == null || userData['id'] == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return;
    }

    String userId = userData['id'].toString();
    print('USUARIO DE SESSION: $userId');

    DateTime dateTime = currentDateTime;

    int milliseconds = _elapsedTime.value;
    int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;

    int totalMinutes = (hours * 60) + minutes;

    Air air = Air(
      fecha: dateTime,
      tiempo: totalMinutes.toString(),
      usuario: userId,
    );

    ResponseApi responseApi = await airProviders.create(air);

    if (responseApi.success == true) {
      int totalMinutes = (hours * 60) + minutes;
      airController.registerAir(totalMinutes);
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', 'No se pudo registrar');
    }
  }
  Future<void> createLuzSolar() async {
    final storage = GetStorage();
    final userData = storage.read('User');

    if (userData == null || userData['id'] == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return;
    }

    String userId = userData['id'].toString();

    // Convertir el tiempo del cronómetro a minutos
    int totalMinutes = _elapsedTime.value ~/ (1000 * 60);

    // Crear el modelo LuzSolar (ajusta según tu modelo real)
    Sun luzSolar = Sun(
      fecha: currentDateTime,
      tiempo: totalMinutes.toString(),
      usuario: userId,
    );

    // Enviar al backend (necesitas un provider para LuzSolar)
    ResponseApi responseApi = await sunProviders.create(luzSolar);

    if (responseApi.success == true) {
      Get.snackbar('Éxito', 'Registro de Luz Solar guardado');
    } else {
      Get.snackbar('Error', 'No se pudo registrar la Luz Solar');
    }
  }
  Future<void> createEjercicio() async {
    final storage = GetStorage();
    final userData = storage.read('User');

    if (userData == null || userData['id'] == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return;
    }

    if (tipoEjercicioSeleccionado.value.isEmpty) {
      Get.snackbar('Error', 'Selecciona un tipo de ejercicio');
      return;
    }

    String userId = userData['id'].toString();
    int totalMinutes = _elapsedTime.value ~/ (1000 * 60);

    // Crear el modelo Ejercicio (ajusta según tu modelo real)
    Exercise ejercicio = Exercise(
      fecha: currentDateTime,
      tiempo: totalMinutes.toString(),
      tipo: tipoEjercicioSeleccionado.value,
      usuario: userId,
    );

    // Enviar al backend (necesitas un provider para Ejercicio)
    ResponseApi responseApi = await exerciseProviders.create(ejercicio);

    if (responseApi.success == true) {
      Get.snackbar('Éxito', 'Registro de Ejercicio guardado');
    } else {
      Get.snackbar('Error', 'No se pudo registrar el Ejercicio');
    }
  }

  void submitData() async {
    final storage = GetStorage();
    final userData = storage.read('User');

    if (userData == null || userData['id'] == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return;
    }

    String userId = userData['id'].toString();
    int totalMinutes = _elapsedTime.value ~/ (1000 * 60); // Tiempo en minutos

    try {
      // 1. Registrar Aire (siempre)
      Air air = Air(
        fecha: currentDateTime,
        tiempo: totalMinutes.toString(),
        usuario: userId,
      );

      ResponseApi airResponse = await airProviders.create(air);

      if (airResponse.success == false) {
        Get.snackbar('Error', 'No se pudo registrar el Aire');
        return;
      }

      // Actualizar porcentaje de Aire
      airController.registerAir(totalMinutes);

      // 2. Registrar Luz Solar (opcional)
      if (sol.value) {
        Sun luzSolar = Sun(
          fecha: currentDateTime,
          tiempo: totalMinutes.toString(),
          usuario: userId,
        );

        ResponseApi luzSolarResponse = await sunProviders.create(luzSolar);

        if (luzSolarResponse.success == false) {
          Get.snackbar('Error', 'No se pudo registrar la Luz Solar');
        } else {
          // Actualizar porcentaje de Luz Solar
          airController.registerSun(totalMinutes); // <- Aquí se envía el tiempo
        }
      }

      // 3. Registrar Ejercicio (opcional)
      if (ejercicio.value) {
        if (tipoEjercicioSeleccionado.value.isEmpty) {
          Get.snackbar('Error', 'Selecciona un tipo de ejercicio');
          return;
        }

        Exercise ejercicioData = Exercise(
          fecha: currentDateTime,
          tiempo: totalMinutes.toString(),
          tipo: tipoEjercicioSeleccionado.value,
          usuario: userId,
        );

        ResponseApi ejercicioResponse = await exerciseProviders.create(ejercicioData);

        if (ejercicioResponse.success == false) {
          Get.snackbar('Error', 'No se pudo registrar el Ejercicio');
        } else {
          // Actualizar porcentaje de Ejercicio
          airController.registerExercise(totalMinutes); // <- Aquí se envía el tiempo
        }
      }

      Get.snackbar('Éxito', 'Registro exitoso');
      resetTimer();

    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error inesperado: ${e.toString()}');
    }
  }

  late Timer _timer;
  RxInt _elapsedTime = 0.obs;
  RxBool _isRunning = false.obs;
  bool _notificationShown = false;

  String get formattedTime => _formatTime(_elapsedTime.value);

  String _formatTime(int milliseconds) {
    int centiseconds = (milliseconds ~/ 10) % 100;
    int seconds = (milliseconds ~/ 1000) % 60;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${centiseconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    if (!_isRunning.value) {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        _elapsedTime.value += 10;
        if (_elapsedTime.value == 30 * 60 * 1000 && !_notificationShown) { // 1 minuto
          _showCompletionNotification();
          pauseTimer();
        }
      });
      _isRunning.value = true;
    }
  }

  void pauseTimer() {
    if (_isRunning.value) {
      _timer.cancel();
      _isRunning.value = false;
    }
  }

  void resetTimer() {
    if (_isRunning.value) {
      _timer.cancel();
    }
    _elapsedTime.value = 0;
    _isRunning.value = false;
    _notificationShown = false;
    _dialogShown = false; // Restablecer el estado del diálogo
  }

  Future<void> _showCompletionNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'completion_channel',
      'Completion Notifications',
      channelDescription: 'Notificación de cumplimiento del cronómetro',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Tiempo requerido cumplido',
      'Ya cumpliste con los 25 minutos de actividad.',
      platformChannelSpecifics,
    );

    await flutterTts.speak('Ya cumpliste con los 25 minutos de actividad.');

    _notificationShown = true;
    _showContinueDialog(Get.context!);
  }

  void _showContinueDialog(BuildContext context) {
    _dialogShown = true; // Marcar el diálogo como mostrado
    Get.defaultDialog(
      title: "Tiempo cumplido",
      titleStyle: TextStyle(color: Colors.black),
      middleText: "¿Deseas continuar con el cronómetro?",
      confirm: TextButton(
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).pop();
          startTimer();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterAirPage()),
          ).then((_) {
            _dialogShown = false; // Restablecer el estado cuando se vuelve
          });
        },
        child: Text("Sí"),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo,
        ),
      ),
      cancel: TextButton(
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterAirPage()),
          ).then((_) {
            _dialogShown = false; // Restablecer el estado cuando se vuelve
          });
        },
        child: Text("No"),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    if (_isRunning.value) {
      _timer.cancel();
    }
    super.onClose();
  }
}
