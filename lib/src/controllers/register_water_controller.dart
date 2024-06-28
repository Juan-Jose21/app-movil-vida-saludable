import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/models/water_models.dart';
import 'package:app_vida_saludable/src/providers/water_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import 'home_controller.dart';

class RegisterWaterController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  WaterProviders feedingProviders = WaterProviders();
  User user = User.fronJson(GetStorage().read('User') ?? {});
  HomeController waterController = Get.find<HomeController>();

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());
  Rx<int> cantidadController = Rx<int>(0);
  Rx<int> ultimaCantidad = Rx<int>(1);

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
  }

  Future<void> _updateDateTime() async {
    _currentDateTime.value = DateTime.now();
    timeController.text = TimeOfDay.fromDateTime(_currentDateTime.value).format(Get.context!);
    update();
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
      await _updateDateTime();
    }
  }

  DateTime get currentDateTime => _currentDateTime.value;

  void incrementCantidadDeVasos() {
    cantidadController.value++;
    update();
  }

  void onTapIcon() {
    incrementCantidadDeVasos();
  }

  void createWater() async {
    print('USUARIO DE SESSION: ${user.toJson()}');
    DateTime dateTime = currentDateTime;

    Water water = Water(
      fecha: dateTime,
      hora: TimeOfDay.fromDateTime(dateTime),
      cantidad: ultimaCantidad.value.toString(),
      user_id: user.id,
    );

    ResponseApi responseApi = await feedingProviders.create(water);

    waterController.register1();
    waterController.registerC();

    Get.snackbar('Registro exitoso', responseApi.message ?? '');

    await _updateDateTime();
  }
}