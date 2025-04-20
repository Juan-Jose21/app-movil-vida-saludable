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
import 'package:shared_preferences/shared_preferences.dart';
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

  // Variables para el cronómetro
  Timer? _timer;
  final Rx<Duration> elapsedTime = Duration.zero.obs;
  final RxBool _isTimerRunning = false.obs;
  DateTime? _timerStartTime;
  final RxString formattedTime = "00:00:00".obs;


  bool get isTimerRunning => _isTimerRunning.value;

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
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

void startTimer() {
  if (!_isTimerRunning.value) {
    _timerStartTime = DateTime.now().subtract(elapsedTime.value);
    _isTimerRunning.value = true;
    update(); // Notifica a los listeners
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value = DateTime.now().difference(_timerStartTime!);
      _updateTimeDisplay();
      update(); // Notifica en cada actualización
    });
  }
}
void pauseTimer() {
  _timer?.cancel();
  _isTimerRunning.value = false;
  update(); // Notifica a los listeners
}
void resetTimer() {
  _timer?.cancel();
  elapsedTime.value = Duration.zero;
  _isTimerRunning.value = false;
  _timerStartTime = null;
  _updateTimeDisplay();
  update(); // Notifica a los listeners
}

  void _updateTimeDisplay() {
    final hours = elapsedTime.value.inHours.toString().padLeft(2, '0');
    final minutes = (elapsedTime.value.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (elapsedTime.value.inSeconds % 60).toString().padLeft(2, '0');
    
    formattedTime.value = "$hours:$minutes:$seconds";
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timerSeconds', elapsedTime.value.inSeconds);
    await prefs.setString('lastTimerSave', DateTime.now().toIso8601String());
    await prefs.setBool('isTimerRunning', _isTimerRunning.value);
  }
    Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSeconds = prefs.getInt('timerSeconds') ?? 0;
    final lastSaveStr = prefs.getString('lastTimerSave');
    final wasRunning = prefs.getBool('isTimerRunning') ?? false;
    
    if (savedSeconds > 0 && lastSaveStr != null) {
      final lastSave = DateTime.parse(lastSaveStr);
      final now = DateTime.now();
      
      if (wasRunning) {
        // Si estaba corriendo, agregar el tiempo transcurrido
        final diff = now.difference(lastSave);
        elapsedTime.value = Duration(seconds: savedSeconds + diff.inSeconds);
      } else {
        // Si estaba pausado, mantener el tiempo guardado
        elapsedTime.value = Duration(seconds: savedSeconds);
      }
      
      _isTimerRunning.value = wasRunning;
      _updateTimeDisplay();
      
      // Reiniciar el timer si estaba corriendo
      if (wasRunning) {
        _timer?.cancel();
        _timerStartTime = now.subtract(elapsedTime.value);
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          elapsedTime.value = DateTime.now().difference(_timerStartTime!);
          _updateTimeDisplay();
        });
      }
    }
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
    'exercise_channel',
    'Exercise Notifications',
    channelDescription: 'Notificaciones de ejercicio',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    '¡Meta alcanzada!',
    'Has completado 30 minutos de ejercicio',
    platformChannelSpecifics,
  );

  await flutterTts.speak('¡Felicidades! Has completado 30 minutos de ejercicio');
  
  // Mostrar diálogo opcional
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
  int totalMinutes = elapsedTime.value.inMinutes; // Esto ya está en minutos

  try {
    String tipo = _selectedMeal.value;

    if (tipo.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes seleccionar un tipo de ejercicio');
      return;
    }

    // Registrar Ejercicio
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

    // Actualizar progreso
    exerciseController.registerExercise(totalMinutes);

    // Registrar Aire Puro (opcional)
    if (airePuro.value) {
      Air air = Air(
        fecha: currentDateTime,
        tiempo: totalMinutes.toString(),
        usuario: userId,
      );

      await airProviders.create(air);
      exerciseController.registerAir(totalMinutes);
    }

    // Registrar Luz Solar (opcional)
    if (luzSolar.value) {
      Sun sun = Sun(
        fecha: currentDateTime,
        tiempo: totalMinutes.toString(),
        usuario: userId,
      );

      await sunProviders.create(sun);
      exerciseController.registerSun(totalMinutes);
    }

    Get.snackbar('Éxito', 'Registro exitoso');
    resetTimer();

  } catch (e) {
    Get.snackbar('Error', 'Ocurrió un error: ${e.toString()}');
  }
}

  // late Timer _timer;
  RxInt _elapsedTime = 0.obs;
  RxBool _isRunning = false.obs;


  // String get formattedTime => _formatTime(_elapsedTime.value);

  String _formatTime(int milliseconds) {
    int centiseconds = (milliseconds ~/ 10) % 100;
    int seconds = (milliseconds ~/ 1000) % 60;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${centiseconds.toString().padLeft(2, '0')}';
  }

  // void startTimer() {
  //   if (!_isRunning.value) {
  //     _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
  //       _elapsedTime.value += 10;
  //       updateMetrics();
  //       if (_elapsedTime.value == 30 * 60 * 1000) { // 1 minuto
  //         _showCompletionNotification();
  //         pauseTimer();
  //       }
  //     });
  //     _isRunning.value = true;
  //   }
  // }

  // void pauseTimer() {
  //   if (_isRunning.value) {
  //     _timer.cancel();
  //     _isRunning.value = false;
  //   }
  // }

  // void resetTimer() {
  //   if (_isRunning.value) {
  //     _timer.cancel();
  //   }
  //   _elapsedTime.value = 0;
  //   _isRunning.value = false;
  //   _dialogShown = false; // Restablecer el estado del diálogo
  // }

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

  // @override
  // void onClose() {
  //   if (_isRunning.value) {
  //     _timer.cancel();
  //   }
  //   super.onClose();
  // }
}
