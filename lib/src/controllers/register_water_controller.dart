import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/models/water_models.dart';
import 'package:app_vida_saludable/src/pages/bottom_bar/bottom_bar_controller.dart';
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
  // User user = User.fronJson(GetStorage().read('User') ?? {});
  HomeController waterController = Get.find<HomeController>();
  BottomBarController pesoController = Get.find<BottomBarController>();

  Rx<DateTime> _currentDateTime = Rx<DateTime>(DateTime.now());
  // Rx<int> cantidadController = Rx<int>(0);
  // Rx<int> ultimaCantidad = Rx<int>(1);
  var ultimaCantidad = 1.obs;
  var cantidadController = 0.obs; // Variable reactiva para la cantidad

  var metaDiaria = 0.obs; // Variable reactiva
  var ultimaBebida = 250.obs; // Variable reactiva para la última bebida
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // _updateDateTime();
    // calculateMeta();
    loadPercentagesFromStorage();
  }
  void loadPercentagesFromStorage() {
    cantidadController.value = box.read('cantidadVasos') ?? 0;
  }

  void calculateMeta() async {
    final storage = GetStorage();
    final userData = storage.read('User');
    String userId = userData['id'].toString();

    // Espera a que los datos físicos se carguen
    await pesoController.listarDatosFisicos(userId);

    // Verifica si hay datos físicos disponibles después de la carga
    if (pesoController.datosFisicos.isNotEmpty) {
      var datosFisicos = pesoController.datosFisicos[0];

      // Extrae el peso del usuario y lo convierte a entero redondeando
      var pesoMeta = datosFisicos?.peso;
      if (pesoMeta != null) {
        int pesoEntero = pesoMeta.round(); // Redondea el peso a entero

        // Calcula la meta de ingesta de agua en mililitros
        int metaSinRedondeo = pesoEntero * 35;

        // Redondea la meta al múltiplo más cercano de 250
        int metaRedondeada = ((metaSinRedondeo + 125) ~/ 250) * 250;

        metaDiaria.value = metaRedondeada; // Asigna la meta redondeada

        print('La meta diaria de ingesta de agua redondeada es de ${metaDiaria.value} ml.');
      } else {
        print('Error: No se encontró el peso del usuario.');
      }
    } else {
      print('Error: No hay datos físicos disponibles.');
    }
  }


  Future<void> _updateDateTime() async {
    _currentDateTime.value = DateTime.now();
    print('Hora actualizada: $_currentDateTime');
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
    final storage = GetStorage();

    final userData = storage.read('User');

    if (userData == null || userData['id'] == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return;
    }

    // Actualiza la hora actual antes de registrar
    await _updateDateTime(); // Llama a este método para actualizar la hora

    // Extraer el ID del usuario
    String userId = userData['id'].toString();
    print('USUARIO DE SESSION: $userId');

    DateTime dateTime = currentDateTime; // Utiliza la hora actualizada

    int total_agua = ultimaCantidad.value * 250;

    Water water = Water(
      fecha: dateTime,
      hora: TimeOfDay.fromDateTime(dateTime),
      cantidad: total_agua.toString(),
      usuario: userId,
    );

    ResponseApi responseApi = await feedingProviders.create(water);

    if (responseApi.success == true) {
      waterController.register1(metaDiaria.value);
      waterController.registerC(metaDiaria.value);
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
    } else {
      Get.snackbar('Error', 'No se pudo registrar');
    }
  }

}
