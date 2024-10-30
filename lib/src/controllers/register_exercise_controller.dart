import 'dart:async';

import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/exercise_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/user.dart';
import '../providers/exercise_providers.dart';

class RegisterExerciseController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  ExerciseProviders exerciseProviders = ExerciseProviders();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  RxString _selectedMeal = ''.obs;

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  User user = User.fronJson(GetStorage().read('User') ?? {});
  HomeController exerciseController = Get.find<HomeController>();

  bool _dialogShown = false; // Variable para controlar si el diálogo ya se mostró

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
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
        // Mostrar el diálogo solo si no se ha mostrado antes
        if (!_dialogShown) {
          _showContinueDialog(Get.context!);
        }
      },
    );
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
      'Ya cumpliste con 25 minuto de ejercicio.',
      platformChannelSpecifics,
    );

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
      usuario: user.id.toString(),
    );

    ResponseApi responseApi = await exerciseProviders.create(exercise);

    if (responseApi.success == true) {
      exerciseController.registerExercise();
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', 'No se pudo registrar');
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
        if (_elapsedTime.value == 1 * 60 * 1000) { // 1 minuto
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
