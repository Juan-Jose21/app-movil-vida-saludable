import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/models/sleep_models.dart';
import 'package:app_vida_saludable/src/models/wake_up_models.dart';
import 'package:app_vida_saludable/src/providers/sleep_providers.dart';
import 'package:app_vida_saludable/src/providers/wake_up_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

import '../models/user.dart';

class RegisterDreamController extends GetxController {

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController como_descansoController = TextEditingController();

  SleepProviders sleepProviders = SleepProviders();
  Wake_upProviders wake_upProviders = Wake_upProviders();
  HomeController dreamController = Get.find<HomeController>();
  User user = User.fronJson(GetStorage().read('User') ?? {});

  RxString _selectedMeal = ''.obs;
  Rx<String> subTitleController = ''.obs;
  RxBool isFormVisible = false.obs;

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  RxBool _durmioBien = false.obs;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    scheduleSleepNotification(); // Schedule the bedtime notification
    _updateDateTime();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification response here, if needed
      },
    );

    // Request notification permissions for Android 13+ (API level 33+)
    if (Platform.isAndroid && (await Permission.notification.isDenied)) {
      PermissionStatus status = await Permission.notification.request();
      if (status != PermissionStatus.granted) {
        print("Notification permission denied.");
      }
    }
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

  void pressed(String select) {
    subTitleController.value = select;
  }

  void onPressed(String meal) {
    _selectedMeal.value = meal;
  }

  void setDurmioBien(bool value) {
    _durmioBien.value = value;
  }

  bool get durmioBien => _durmioBien.value;

  DateTime get currentDateTime => _currentDateTime.value;

  void createSleep() async {
    print('USUARIO DE SESSION: ${user.toJson()}');
    DateTime dateTime = currentDateTime;

    Sleep sleep = Sleep(
      fecha: dateTime,
      hora: TimeOfDay.fromDateTime(dateTime),
      usuario: user.id.toString(),
    );

    ResponseApi responseApi = await sleepProviders.create(sleep);

    if (responseApi.success == true) {
      dreamController.registerDormir();
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', 'No se pudo registrar');
    }
  }

  void createWake_up() async {
    print('USUARIO DE SESSION: ${user.toJson()}');
    bool como_descanso = durmioBien;
    String estado = como_descanso ? '1' : '0';

    print("DATO: $estado");

    if (estado.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
      return;
    }

    DateTime dateTime = currentDateTime;

    Wake_up wake_up = Wake_up(
      fecha: dateTime,
      hora: TimeOfDay.fromDateTime(dateTime),
      estado: estado,
      usuario: user.id.toString(),
    );

    ResponseApi responseApi = await wake_upProviders.create(wake_up);

    if (responseApi.success == true) {
      dreamController.registerDespertar();
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', 'No se pudo registrar');
    }
  }

  void toggleFormVisibility() {
    isFormVisible.value = !isFormVisible.value;
  }

  Future<void> scheduleSleepNotification() async {
    DateTime now = DateTime.now();
    DateTime sleepTime = DateTime(now.year, now.month, now.day, 22, 0); // Schedule at 10:00 PM

    if (sleepTime.isBefore(now)) {
      sleepTime = sleepTime.add(Duration(days: 1)); // Schedule for the next day if already passed
    }

    tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(sleepTime, tz.local);
    const int notificationId = 4;
    const String notificationTitle = 'Hora de Dormir';
    const String notificationBody = 'Es momento de prepararte para dormir.';

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'sleep_reminder_channel',
      'Sleep Reminders',
      channelDescription: 'Notificaciones para recordar la hora de dormir',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    print('Scheduling sleep notification at: $sleepTime'); // Debug print

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      notificationTitle,
      notificationBody,
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: notificationBody,
    );
  }
}
