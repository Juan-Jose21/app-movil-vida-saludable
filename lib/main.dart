import 'dart:async';
import 'package:app_vida_saludable/src/controllers/home_controller.dart';
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
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/La_Paz'));

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Get.put(HomeController());
  Get.put(RegisterFeedingController());
  Get.put(RegisterDreamController());

  final now = DateTime.now();
  final midnight = DateTime(now.year, now.month, now.day + 1);
  final timeUntilMidnight = midnight.difference(now);

  print('Programando borrado de datos a medianoche: $midnight');

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask(
    "simple_task",
    "simple_task",
    initialDelay: Duration(seconds: timeUntilMidnight.inSeconds),
  );

  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Tarea ejecutada: $task");
    try {
      await GetStorage.init();
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('America/La_Paz'));

      if (!Get.isRegistered<HomeController>()) {
        Get.lazyPut(() => HomeController());
      }

      Get.find<HomeController>().resetAllPercentages();
      print("Datos reiniciados correctamente.");
      return Future.value(true);
    } catch (e) {
      print("Error al ejecutar la tarea: $e");
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
        colorScheme: ColorScheme(
            primary: Colors.indigo,
            secondary: Colors.indigoAccent,
            brightness: Brightness.light,
            onBackground: Colors.grey,
            onPrimary: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
            onSecondary: Colors.grey,
            background: Colors.white
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
