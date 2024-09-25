import 'dart:async';

import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/exercise_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../providers/exercise_providers.dart';

class RegisterExerciseController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  ExerciseProviders exerciseProviders = ExerciseProviders();

  RxString _selectedMeal = ''.obs;

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  User user = User.fronJson(GetStorage().read('User') ?? {});
  HomeController exerciseController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
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

    print('USUARIO DE SESSION: ${user.toJson()}');
    String tipo = _selectedMeal.value;

    if (tipo.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
      return;
    }

    DateTime dateTime = currentDateTime;

    Exercise exercise = Exercise(
      fecha: dateTime,
      tipo: tipo,
      tiempo: formattedTime,
      user_id: user.id.toString(),
    );

    ResponseApi responseApi = await exerciseProviders.create(exercise);

    if(responseApi.success == true){
      exerciseController.registerExercise();
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    }
    else{
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
  }


  @override
  void onClose() {
    if (_isRunning.value) {
      _timer.cancel();
    }
    super.onClose();
  }
}
