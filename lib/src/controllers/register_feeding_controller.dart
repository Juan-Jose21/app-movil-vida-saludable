import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/feeding_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/providers/feeding_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

import '../models/user.dart';

class RegisterFeedingController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController tipo_alimentoController = TextEditingController();
  TextEditingController saludableController = TextEditingController();

  User user = User.fronJson(GetStorage().read('User') ?? {});
  FeedingProviders feedingProviders = FeedingProviders();

  RxString _selectedMeal = ''.obs;
  RxString _selected = ''.obs;
  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  HomeController feedingController = Get.find<HomeController>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FlutterTts flutterTts = FlutterTts();

  @override
  void onInit() {
    super.onInit();
    tz.initializeTimeZones(); // Correctly initialize time zones
    _initializeNotifications();
    _initializeTTS();
    scheduleAllMealNotifications(); // Schedule notifications daily
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
        _speakNotification(response.payload ?? '');
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

  void _initializeTTS() {
    flutterTts.setLanguage("es-ES");
    flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speakNotification(String message) async {
    await flutterTts.speak(message);
  }

  Future<void> _updateDateTime() async {
    _currentDateTime.value = DateTime.now();
  }

  Future<void> scheduleMealNotification(String mealType, DateTime scheduledTime) async {
    tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
    int notificationId;
    String notificationTitle;
    String notificationBody;

    switch (mealType) {
      case 'desayuno':
        notificationId = 1;
        notificationTitle = 'Hora del Desayuno';
        notificationBody = 'Es momento de registrar tu desayuno.';
        break;
      case 'almuerzo':
        notificationId = 2;
        notificationTitle = 'Hora del Almuerzo';
        notificationBody = 'Es momento de registrar tu almuerzo.';
        break;
      case 'cena':
        notificationId = 3;
        notificationTitle = 'Hora de la Cena';
        notificationBody = 'Es momento de registrar tu cena.';
        break;
      default:
        return;
    }

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'meal_reminder_channel',
      'Meal Reminders',
      channelDescription: 'Notificaciones para recordar el registro de comidas',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    print('Scheduling $mealType notification at: $scheduledTime'); // Debug print

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      notificationTitle,
      notificationBody,
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: notificationBody, // The content to be read aloud
    );
  }

  void scheduleAllMealNotifications() {
    DateTime now = DateTime.now();

    // Schedule breakfast notification at 8:00 AM
    DateTime breakfastTime = DateTime(now.year, now.month, now.day, 8, 0);
    if (breakfastTime.isBefore(now)) {
      breakfastTime = breakfastTime.add(Duration(days: 1)); // Schedule for the next day
    }
    scheduleMealNotification('desayuno', breakfastTime);

    // Schedule lunch notification at 1:00 PM
    DateTime lunchTime = DateTime(now.year, now.month, now.day, 12, 30);
    if (lunchTime.isBefore(now)) {
      lunchTime = lunchTime.add(Duration(days: 1)); // Schedule for the next day
    }
    scheduleMealNotification('almuerzo', lunchTime);

    // Schedule dinner notification at 8:00 PM
    DateTime dinnerTime = DateTime(now.year, now.month, now.day, 19, 30);
    if (dinnerTime.isBefore(now)) {
      dinnerTime = dinnerTime.add(Duration(days: 1)); // Schedule for the next day
    }
    scheduleMealNotification('cena', dinnerTime);
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
      await selectTime(); // Select time after date
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

  void onPressed(String meal) {
    _selectedMeal.value = meal;
  }

  void pressed(String select) {
    _selected.value = select;
  }

  // Button color change logic based on selection
  Color get buttonColorDesayuno => _selectedMeal.value == 'desayuno' ? Colors.indigo : Colors.white60;
  Color get buttonColorAlmuerzo => _selectedMeal.value == 'almuerzo' ? Colors.indigo : Colors.white60;
  Color get buttonColorCena => _selectedMeal.value == 'cena' ? Colors.indigo : Colors.white60;
  Color get buttonColorOtro => _selectedMeal.value == 'otro' ? Colors.indigo : Colors.white60;
  Color get buttonColorSi => _selected.value == 'si' ? Colors.indigo : Colors.white60;
  Color get buttonColorNo => _selected.value == 'no' ? Colors.indigo : Colors.white60;

  Color get textColorDesayuno => _selectedMeal.value == 'desayuno' ? Colors.white : Colors.black87;
  Color get textColorAlmuerzo => _selectedMeal.value == 'almuerzo' ? Colors.white : Colors.black87;
  Color get textColorCena => _selectedMeal.value == 'cena' ? Colors.white : Colors.black87;
  Color get textColorOtro => _selectedMeal.value == 'otro' ? Colors.white : Colors.black87;
  Color get textColorSi => _selected.value == 'si' ? Colors.white : Colors.black87;
  Color get textColorNo => _selected.value == 'no' ? Colors.white : Colors.black87;

  var desayunoRegistrado = false.obs;
  var isHoraPasada = true.obs;

  void updateHoraPasada() {
    DateTime now = DateTime.now();
    DateTime horaDesayuno = DateTime(now.year, now.month, now.day, 8, 0);
    isHoraPasada.value = now.isAfter(horaDesayuno);
    print('State Hora: ${isHoraPasada.value}');
  }

  void updateDesayunoRegistrado(bool value) {
    desayunoRegistrado.value = value;
    print('State: ${desayunoRegistrado.value}');
  }

  DateTime get currentDateTime => _currentDateTime.value;

  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes:00';
  }

  Future<void> createFeeding() async {
    String tipo_alimento = _selectedMeal.value;
    String saludable = _selected.value;

    // Validation
    if (tipo_alimento.isEmpty || saludable.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
      return;
    }

    DateTime dateTime = currentDateTime;

    Feeding feeding = Feeding(
      usuario: user.id.toString(),
      fecha: dateTime,
    );

    switch (tipo_alimento) {
      case 'desayuno':
        feeding.desayuno = 1;
        feeding.desayuno_hora = TimeOfDay.fromDateTime(dateTime);
        feeding.desayuno_saludable = (saludable == 'si') ? 1 : 0;
        break;
      case 'almuerzo':
        feeding.almuerzo = 1;
        feeding.almuerzo_hora = TimeOfDay.fromDateTime(dateTime);
        feeding.almuerzo_saludable = (saludable == 'si') ? 1 : 0;
        break;
      case 'cena':
        feeding.cena = 1;
        feeding.cena_hora = TimeOfDay.fromDateTime(dateTime);
        feeding.cena_saludable = (saludable == 'si') ? 1 : 0;
        break;
      default:
        Get.snackbar('Error', 'Tipo de comida no válido');
        return;
    }

    ResponseApi responseApi;
    switch (tipo_alimento) {
      case 'desayuno':
        responseApi = await feedingProviders.createDesayuno(feeding);
        break;
      case 'almuerzo':
        responseApi = await feedingProviders.createAlmuerzo(feeding);
        break;
      case 'cena':
        responseApi = await feedingProviders.createCena(feeding);
        break;
      default:
        return;
    }

    if (responseApi.success == true) {
      switch (tipo_alimento) {
        case 'desayuno':
          feedingController.registerBreakfast();
          break;
        case 'almuerzo':
          feedingController.registerLunch();
          break;
        case 'cena':
          feedingController.registerDinner();
          break;
      }
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', responseApi.message ?? 'No se pudo registrar');
    }
  }
}
