import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/feeding_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/providers/feeding_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  void pressed(String select) {
    _selected.value = select;
  }

  Color get buttonColorDesayuno =>
      _selectedMeal.value == 'desayuno' ? Colors.indigo : Colors.white60;

  Color get buttonColorAlmuerzo =>
      _selectedMeal.value == 'almuerzo' ? Colors.indigo : Colors.white60;

  Color get buttonColorCena =>
      _selectedMeal.value == 'cena' ? Colors.indigo : Colors.white60;

  Color get buttonColorOtro =>
      _selectedMeal.value == 'otro' ? Colors.indigo : Colors.white60;

  Color get buttonColorSi =>
      _selected.value == 'si' ? Colors.indigo : Colors.white60;

  Color get buttonColorNo =>
      _selected.value == 'no' ? Colors.indigo : Colors.white60;

  Color get textColorDesayuno =>
      _selectedMeal.value == 'desayuno' ? Colors.white : Colors.black87;

  Color get textColorAlmuerzo =>
      _selectedMeal.value == 'almuerzo' ? Colors.white : Colors.black87;

  Color get textColorCena =>
      _selectedMeal.value == 'cena' ? Colors.white : Colors.black87;

  Color get textColorOtro =>
      _selectedMeal.value == 'otro' ? Colors.white : Colors.black87;

  Color get textColorSi =>
      _selected.value == 'si' ? Colors.white : Colors.black87;

  Color get textColorNo =>
      _selected.value == 'no' ? Colors.white : Colors.black87;

  var desayunoRegistrado = false.obs;
  var isHoraPasada = true.obs;

  void updateHoraPasada() {
    DateTime now = DateTime.now();
    DateTime horaDesayuno = DateTime(now.year, now.month, now.day, 8, 0);
    isHoraPasada.value = now.isAfter(horaDesayuno);
    print('State Hora: ${isHoraPasada.value}');
  }

  void updateDesayunoRegistrado(bool value) {
    isHoraPasada.value = value;
    print('State: ${desayunoRegistrado.value}');
  }

  DateTime get currentDateTime => _currentDateTime.value;

  void createFeeding() async {
    print('USUARIO: ${user.toJson()}');
    String tipo_alimento = _selectedMeal.value;
    String saludable = _selected.value;

    if (tipo_alimento.isEmpty || saludable.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
      return;
    }

    DateTime dateTime = currentDateTime;

    Feeding feeding = Feeding(
      fecha: dateTime,
      hora: TimeOfDay.fromDateTime(dateTime),
      tipo_alimento: tipo_alimento,
      saludable: saludable,
      user_id: user.id.toString(),
    );

    ResponseApi responseApi = await feedingProviders.create(feeding);

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
        default:
          break;
      }
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', responseApi.message ?? 'No se pudo registrar');
    }
  }
}
