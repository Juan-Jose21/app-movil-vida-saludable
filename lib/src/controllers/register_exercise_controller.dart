import 'dart:async';

import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/exercise_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_exercise_page.dart';
import 'package:app_vida_saludable/src/providers/air_providers.dart';
import 'package:app_vida_saludable/src/providers/sun_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/air_models.dart';
import '../models/sun_models.dart';
import '../providers/exercise_providers.dart';

class RegisterExerciseController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  ExerciseProviders exerciseProviders = ExerciseProviders();
  AirProviders airProviders = AirProviders();
  SunProviders sunProviders = SunProviders();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late FlutterTts flutterTts;
  bool _notificationShown = false;

  // En RegisterExerciseController
  var steps = 0.obs;
  var calories = 0.obs;
  var distance = 0.obs; // en metros
  var progressValue = 0.0.obs;

  // En RegisterExerciseController
  var luzSolar = false.obs;
  var airePuro = false.obs;

  RxString _selectedMeal = ''.obs;

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  // User user = User.fronJson(GetStorage().read('User') ?? {});
  HomeController exerciseController = Get.find<HomeController>();

  bool _dialogShown = false; // Variable para controlar si el diálogo ya se mostró

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
    _initTextToSpeech();
    _updateDateTime();
  }

// Método para actualizar métricas (simulado)
  void updateMetrics() {
    steps.value = (steps.value + 50).clamp(0, 10000); // Ejemplo: incrementa pasos
    calories.value = (steps.value * 0.04).toInt(); // 0.04 calorías por paso
    distance.value = (steps.value * 0.762).toInt(); // 0.762 metros por paso (promedio)
    progressValue.value = (steps.value / 10000).clamp(0.0, 1.0); // Meta de 10,000 pasos
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
        // Mostrar el diálogo solo si no se ha mostrado antes
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
      'Ya cumpliste con los 30 minutos de ejercicio.',
      platformChannelSpecifics,
    );

    await flutterTts.speak('Ya cumpliste con los 25 minutos de actividad.');

    _notificationShown = true;
    _showContinueDialog(Get.context!);
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

  void onPressed(String meal) {
    _selectedMeal.value = meal;
  }

  Color get buttonColorDesayuno =>
      _selectedMeal.value == 'caminata lenta' ? Colors.indigo : Colors.white60;

  Color get buttonColorAlmuerzo =>
      _selectedMeal.value == 'caminata rapida' ? Colors.indigo : Colors.white60;

  Color get buttonColorCena =>
      _selectedMeal.value == 'trote' ? Colors.indigo : Colors.white60;

  Color get buttonColorOtro =>
      _selectedMeal.value == 'ejercicio guiado' ? Colors.indigo : Colors.white60;

  Color get textColorDesayuno =>
      _selectedMeal.value == 'caminata lenta' ? Colors.white : Colors.black87;

  Color get textColorAlmuerzo =>
      _selectedMeal.value == 'caminata rapida' ? Colors.white : Colors.black87;

  Color get textColorCena =>
      _selectedMeal.value == 'trote' ? Colors.white : Colors.black87;

  Color get textColorOtro =>
      _selectedMeal.value == 'ejercicio guiado' ? Colors.white : Colors.black87;

  var desayunoRegistrado = false.obs;
  var isHoraPasada = true.obs;

  DateTime get currentDateTime => _currentDateTime.value;

  void createExercise() async {
    final storage = GetStorage();

    final userData = storage.read('User');

    if (userData == null || userData['id'] == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return;
    }
    // Extraer el ID del usuario
    String userId = userData['id'].toString();
    print('USUARIO DE SESSION: $userId');

    String tipo = _selectedMeal.value;

    if (tipo.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
      return;
    }

    DateTime dateTime = currentDateTime;

    int milliseconds = _elapsedTime.value;
    int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;

    int totalMinutes = (hours * 60) + minutes;

    Exercise exercise = Exercise(
      fecha: dateTime,
      tipo: tipo,
      tiempo: totalMinutes.toString(),
      usuario: userId,
    );

    ResponseApi responseApi = await exerciseProviders.create(exercise);

    if (responseApi.success == true) {
      int totalMinutes = (hours * 60) + minutes;
      exerciseController.registerExercise(totalMinutes);
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
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', 'No se pudo registrar');
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
      String tipo = _selectedMeal.value;

      if (tipo.isEmpty) {
        Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
        return;
      }
      // 1. Registrar Ejercicio (siempre)
      Exercise exercise = Exercise(
        fecha: currentDateTime,
        tiempo: totalMinutes.toString(),
        tipo: tipo,
        usuario: userId,
      );

      ResponseApi exerciseResponse = await exerciseProviders.create(exercise);

      if (exerciseResponse.success == false) {
        Get.snackbar('Error', 'No se pudo registrar el Ejercicio');
        return;
      }

      // Actualizar porcentaje de Aire
      exerciseController.registerExercise(totalMinutes);

      // 2. Registrar Aire Puro (opcional)
      if (airePuro.value) {
        Air air = Air(
          fecha: currentDateTime,
          tiempo: totalMinutes.toString(),
          usuario: userId,
        );

        ResponseApi airResponse = await airProviders.create(air);

        if (airResponse.success == false) {
          Get.snackbar('Error', 'No se pudo registrar la Aire Puro');
        } else {
          // Actualizar porcentaje de Luz Solar
          exerciseController.registerAir(totalMinutes); // <- Aquí se envía el tiempo
        }
      }

      // 3. Registrar Luz Solar (opcional)
      if (luzSolar.value) {
        Sun sun = Sun(
          fecha: currentDateTime,
          tiempo: totalMinutes.toString(),
          usuario: userId,
        );

        ResponseApi sunResponse = await sunProviders.create(sun);

        if (sunResponse.success == false) {
          Get.snackbar('Error', 'No se pudo registrar la Luz Solar');
        } else {
          // Actualizar porcentaje de Luz Solar
          exerciseController.registerSun(totalMinutes); // <- Aquí se envía el tiempo
        }
      }

      Get.snackbar('Éxito', 'Registro exitoso');
      resetTimer();

    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error inesperado en todos: ${e.toString()}');
    }
  }

  late Timer _timer;
  RxInt _elapsedTime = 0.obs;
  RxBool _isRunning = false.obs;


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
        updateMetrics();
        if (_elapsedTime.value == 30 * 60 * 1000) { // 1 minuto
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
    _dialogShown = false; // Restablecer el estado del diálogo
  }

  void _showContinueDialog(BuildContext context) {
    if (_dialogShown) return; // Si el diálogo ya se mostró, no hacer nada
    _dialogShown = true;

    Get.defaultDialog(
      title: "Ejercicio Completo",
      titleStyle: TextStyle(color: Colors.black),
      middleText: "¿Deseas continuar con el cronómetro?",
      confirm: TextButton(
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).pop();
          startTimer();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterExercisePage()),
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
            MaterialPageRoute(builder: (context) => RegisterExercisePage()),
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
