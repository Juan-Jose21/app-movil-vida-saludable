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


User userSession = User.fronJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/La_Paz'));
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
    // Get.put(StatisticsController());
    return GetMaterialApp(
      title: 'Vida Saludable',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? '/bar' : '/',
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
          )
      ),
      navigatorKey: Get.key,
    );
  }
}
