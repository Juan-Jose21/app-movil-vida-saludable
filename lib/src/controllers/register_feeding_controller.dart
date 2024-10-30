import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/feeding_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_feeding.dart';
import 'package:app_vida_saludable/src/providers/feeding_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

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

  BuildContext? globalContext; // Variable para almacenar el contexto

  bool _dialogShown = false;
  @override
  void onInit() {
    super.onInit();
    initializeNotifications();
  }

  void setContext(BuildContext context) {
    globalContext = context;
  }

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    await _initializeNotifications();
    await _initializeTTS();
    await _requestPermissions();
    await _scheduleDailyNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'meal_reminder_channel',
      'Meal Reminders',
      description: 'Recordatorios para registrar tus comidas',
      importance: Importance.max,
      enableVibration: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        _speakNotification(response.payload ?? 'Es momento de registrar tu comida.');
        // Get.toNamed('/registerFeeding');
        // if (!_dialogShown) {
        //   _showContinueDialog(Get.context!);
        // }
      },
    );
  }
  void _showContinueDialog(BuildContext context) {
    _dialogShown = true; // Marcar el diálogo como mostrado
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterFeedingPage()),
    ).then((_) {
      _dialogShown = false; // Restablecer el estado cuando se vuelve
    });
  }

  Future<void> _initializeTTS() async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _requestPermissions() async {
    await [Permission.notification, Permission.microphone].request();
  }

  Future<void> _scheduleDailyNotifications() async {
    final mealSchedules = [
      {'time': TimeOfDay(hour: 8, minute: 0), 'type': 'desayuno'},
      {'time': TimeOfDay(hour: 12, minute: 30), 'type': 'almuerzo'},
      {'time': TimeOfDay(hour: 19, minute: 30), 'type': 'cena'},
    ];

    for (var meal in mealSchedules) {
      await _scheduleNotification(
        mealType: meal['type'] as String,
        timeOfDay: meal['time'] as TimeOfDay,
      );
    }
  }

  Future<void> _scheduleNotification({
    required String mealType,
    required TimeOfDay timeOfDay,
  }) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    final tzDateTime = tz.TZDateTime.from(scheduledDate, tz.local);

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'meal_reminder_channel',
      'Recordatorios de Comidas',
      channelDescription: 'Recordatorios para registrar tus comidas diarias',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      mealType.hashCode,
      _getNotificationTitle(mealType),
      _getNotificationBody(mealType),
      tzDateTime,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: _getNotificationBody(mealType),
    );
  }

  String _getNotificationTitle(String mealType) {
    switch (mealType) {
      case 'desayuno':
        return '🍳 Hora del Desayuno';
      case 'almuerzo':
        return '🍽️ Hora del Almuerzo';
      case 'cena':
        return '🌙 Hora de la Cena';
      default:
        return '¡Es momento de registrar tu comida!';
    }
  }

  String _getNotificationBody(String mealType) {
    switch (mealType) {
      case 'desayuno':
        return '¡Buenos días! Registra tu desayuno.';
      case 'almuerzo':
        return 'Es mediodía, registra tu almuerzo.';
      case 'cena':
        return 'Es hora de la cena, no olvides registrarla.';
      default:
        return 'Recuerda registrar tu comida.';
    }
  }

  Future<void> _speakNotification(String message) async {
    await flutterTts.stop();
    await flutterTts.speak(message);
  }

  void onPressed(String meal) {
    _selectedMeal.value = meal;
  }

  void pressed(String select) {
    _selected.value = select;
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
    print('USUARIO DE SESSION: ${user.toJson()}');
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
