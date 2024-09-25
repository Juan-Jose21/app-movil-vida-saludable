import 'dart:async';
import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/providers/sun_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/sun_models.dart';
import '../models/user.dart';

class RegisterSunController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  late Timer _timer;
  RxInt _elapsedTime = 0.obs;
  RxBool _isRunning = false.obs;

  SunProviders sunProviders = SunProviders();
  User user = User.fronJson(GetStorage().read('User') ?? {});

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  HomeController sunController = Get.find<HomeController>();

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
            colorScheme: const ColorScheme.light(
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
            colorScheme: const ColorScheme.light(
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

String get formattedTime => _formatTime(_elapsedTime.value);

String _formatTime(int milliseconds) {
  int centiseconds = (milliseconds ~/ 10) % 100;
  int seconds = (milliseconds ~/ 1000) % 60;
  int minutes = (milliseconds ~/ (1000 * 60)) % 60;
  int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;

  // Retornar el formato original si necesitas mostrarlo
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${centiseconds.toString().padLeft(2, '0')}';
}

DateTime get currentDateTime => _currentDateTime.value;
DateTime get endDateTime => currentDateTime.add(const Duration(minutes: 45));

void createSun() async {
  print('USUARIO DE SESSION: ${user.toJson()}');
  DateTime dateTime = currentDateTime;

  // Obtener horas y minutos a partir de _elapsedTime
  int milliseconds = _elapsedTime.value;
  int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24; // Horas
  int minutes = (milliseconds ~/ (1000 * 60)) % 60;   // Minutos

  // Calcular el total de minutos
  int totalMinutes = (hours * 60) + minutes; // Total en minutos

  Sun sun = Sun(
    fecha: dateTime,
    tiempo: totalMinutes.toString(), // Enviar el total en minutos como String
    usuario: user.id.toString(),
  );

  ResponseApi responseApi = await sunProviders.create(sun);

  if (responseApi.success == true) {
    sunController.registerSun();
    Get.snackbar('Registro exitoso', responseApi.message ?? '');
  } else {
    Get.snackbar('Error', 'No se pudo registrar');
  }
}



  void startTimer() {
    if (!_isRunning.value) {
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
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
