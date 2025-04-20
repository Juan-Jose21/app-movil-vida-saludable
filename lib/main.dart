// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/controllers/pedometer_controller.dart';
import 'package:app_vida_saludable/src/controllers/register_dream_controller.dart';
import 'package:app_vida_saludable/src/controllers/register_feeding_controller.dart';
import 'package:app_vida_saludable/src/models/user.dart';
import 'package:app_vida_saludable/src/pages/bottom_bar/bottom_bar.dart';
import 'package:app_vida_saludable/src/pages/home/home_pages.dart';
import 'package:app_vida_saludable/src/pages/informations/informations_pages.dart';
import 'package:app_vida_saludable/src/pages/login/login_pages.dart';
import 'package:app_vida_saludable/src/pages/settins/settings_page.dart';
import 'package:app_vida_saludable/src/pages/statistics/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa almacenamiento
  await GetStorage.init();

  // Configuración inicial
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/La_Paz'));

  // Solicitar permisos
  final permissionsGranted = await _requestPermissions();
  
  if (permissionsGranted) {
    // Inicializa controladores
    Get.put(HomeController());
    Get.put(RegisterFeedingController());
    Get.put(RegisterDreamController());
    await Get.put(PedometerController()).initializeService();

    // Configura Workmanager
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    _scheduleDailyTask();

    runApp(const MyApp());
  } else {
    // Manejo cuando los permisos no son concedidos
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('La aplicación necesita permisos para funcionar correctamente'),
        ),
      ),
    ));
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Tarea ejecutada: $task");
    
    try {
      // Inicializa GetStorage independientemente
      await GetStorage.init();
      
      // Para operaciones que necesitan GetX, usa esto:
      if (!Get.isRegistered<HomeController>()) {
        Get.put(HomeController(), permanent: true);
      }
      
      // Ejecuta la operación
      Get.find<HomeController>().resetAllPercentages();
      print("Datos reiniciados correctamente.");
      
      return Future.value(true);
    } catch (e) {
      print("Error en callbackDispatcher: $e");
      return Future.value(false);
    }
  });
}

int timeUntilMidnightInSeconds() {
  final now = DateTime.now();
  final midnight = DateTime(now.year, now.month, now.day + 1);
  final timeUntilMidnight = midnight.difference(now);
  return timeUntilMidnight.inSeconds;
}

void _scheduleDailyTask() {
  Workmanager().cancelAll();
  
  final now = DateTime.now();
  final midnight = DateTime(now.year, now.month, now.day + 1);
  final timeUntilMidnight = midnight.difference(now);

  Workmanager().registerOneOffTask(
    "daily_reset",
    "reset_task",
    initialDelay: timeUntilMidnight,
    constraints: Constraints(
      networkType: NetworkType.not_required,
      requiresBatteryNotLow: false,
      requiresCharging: false,
    ),
    existingWorkPolicy: ExistingWorkPolicy.replace,
    backoffPolicy: BackoffPolicy.exponential,
    backoffPolicyDelay: Duration(minutes: 30),
  );
}

Future<bool> _requestPermissions() async {
  try {
    bool allGranted = true;
    
    final permissions = [
      Permission.activityRecognition,
      Permission.sensors,
      Permission.notification,
    ];

    // Primero verifica el estado sin solicitar
    for (final permission in permissions) {
      final status = await permission.status;
      if (!status.isGranted) {
        final result = await permission.request();
        if (!result.isGranted) {
          allGranted = false;
          // Muestra explicación si es necesario
          if (await permission.shouldShowRequestRationale) {
            Get.dialog(
              AlertDialog(
                title: Text('Permiso requerido'),
                content: Text('Necesitamos este permiso para que el podómetro funcione correctamente'),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      }
    }
    
    return allGranted;
  } catch (e) {
    print('Error al manejar permisos: $e');
    return false;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User userSession = User.fronJson(GetStorage().read('User') ?? {});
    return GetMaterialApp(
      title: 'Vida Saludable',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.access != null ? '/bar' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/bar', page: () => BottomBarPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/statistics', page: () => StatisticsPage()),
        GetPage(name: '/informations', page: () => InformationsPage()),
        GetPage(name: '/settings', page: () => SettingsPage())
      ],
      theme: ThemeData(
        primaryColor: Colors.indigo,
        colorScheme: ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.indigoAccent,
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
