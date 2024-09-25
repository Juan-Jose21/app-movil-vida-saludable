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

  final box = GetStorage(); // Inicializa GetStorage

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();

    // Carga el valor almacenado en GetStorage al inicializar
    cantidadController.value = box.read('cantidadVasos') ?? 0;
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
    box.write('cantidadVasos', cantidadController.value);
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
      user_id: user.id.toString(),
    );

    ResponseApi responseApi = await feedingProviders.create(water);

    if(responseApi.success == true){
      waterController.register1();
      waterController.registerC();
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    }
    else{
      Get.snackbar('Error', 'No se pudo registrar');
    }

    await _updateDateTime();
  }
}
