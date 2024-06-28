import 'package:app_vida_saludable/src/models/hope_models.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../providers/hope_providers.dart';
import 'home_controller.dart';

class RegisterHopeController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController tipo_practicaController = TextEditingController();

  HopeProviders hopeProviders = HopeProviders();
  User user = User.fronJson(GetStorage().read('User') ?? {});

  RxString _selected = ''.obs;
  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());

  HomeController hopeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
  }

  Future<void> _updateDateTime() async {
    _currentDateTime.value = DateTime.now();
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

  void pressed(String select) {
    _selected.value = select;
  }

  DateTime get currentDateTime => _currentDateTime.value;

  void createHope() async {
    print('USUARIO DE SESSION: ${user.toJson()}');
    String tipo_practica = _selected.value;
    print('Tipo: ${tipo_practica}');


    if (tipo_practica.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes llenar todos los campos');
      return;
    }

    DateTime dateTime = currentDateTime;

    Hope hope = Hope(
      fecha: dateTime,
      tipo_practica: tipo_practica,
      user_id: user.id,
    );

    ResponseApi responseApi = await hopeProviders.create(hope);

    if (responseApi.success = true) {
      switch (tipo_practica) {
        case 'oracion':
          hopeController.registerOrar();
          break;
        case 'lectura biblica':
          hopeController.registerLeerBiblia();
          break;
        default:
          break;
      }
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', responseApi.message ?? 'No se pudo registrar');
    }

    await _updateDateTime();
  }
}