import 'package:app_vida_saludable/src/providers/air_providers.dart';
import 'package:app_vida_saludable/src/providers/exercise_providers.dart';
import 'package:app_vida_saludable/src/providers/feeding_providers.dart';
import 'package:app_vida_saludable/src/providers/hope_providers.dart';
import 'package:app_vida_saludable/src/providers/sun_providers.dart';
import 'package:app_vida_saludable/src/providers/wake_up_providers.dart';
import 'package:app_vida_saludable/src/providers/water_providers.dart';
import 'package:get/get.dart';
import 'package:app_vida_saludable/src/models/user.dart';
// import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import '../models/response_api.dart';

class StatisticsController extends GetxController {

  User user = User.fronJson(GetStorage().read('User') ?? {});
  FeedingProviders _feedingProviders = FeedingProviders();
  ExerciseProviders _exerciseProviders = ExerciseProviders();
  WaterProviders _waterProviders = WaterProviders();
  Wake_upProviders _wake_upProviders = Wake_upProviders();
  SunProviders _sunProviders = SunProviders();
  AirProviders _airProviders = AirProviders();
  HopeProviders _hopeProviders = HopeProviders();

  var isLoading = false.obs;
  RxInt no = 0.obs;
  RxInt si = 0.obs;

  RxInt bien = 0.obs;
  RxInt mal = 0.obs;

  RxInt oracion = 0.obs;
  RxInt l_biblia = 0.obs;

  RxInt c_lenta = 0.obs;
  RxInt c_rapida = 0.obs;
  RxInt trote = 0.obs;
  RxInt e_guiado = 0.obs;

  RxString _selectedMeal = ''.obs;

  var datosAlimentacionE = <Map<String, dynamic>>[].obs;
  var datosAlimentacionT = <Map<String, dynamic>>[].obs;

  var datosEjercicioTipo = <Map<String, dynamic>>[].obs;
  var datosEjercicioTiempo = <Map<String, dynamic>>[].obs;
  var datosTipoE = <Map<String, dynamic>>[].obs;

  var datosAgua = <Map<String, dynamic>>[].obs;

  var datosDescanso = <Map<String, dynamic>>[].obs;

  var datosSol = <Map<String, dynamic>>[].obs;

  var datosAire = <Map<String, dynamic>>[].obs;

  var datosHope = <Map<String, dynamic>>[].obs;

  StatisticsController() {
    // print('USUARIO DE SESSION: ${user.toJson()}');
    datosAlimentacion(user.id.toString());
    // Get.forceAppUpdate();
  }

  void datosAlimentacion(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _feedingProviders.datosEstadisticos(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        datosAlimentacionE.assignAll(dataList.map((item) => item as Map<String, dynamic>).toList());

        if (datosAlimentacionE.isNotEmpty) {
          no.value = datosAlimentacionE.first['no_saludables'] ?? 0;
          si.value = datosAlimentacionE.first['si_saludables'] ?? 0;
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void onPressed(String meal) {
    _selectedMeal.value = meal;
  }

  Color get buttonColorDesayuno => _selectedMeal.value == 'desayuno' ? Colors.indigo : Colors.white60;

  Color get buttonColorAlmuerzo => _selectedMeal.value == 'almuerzo' ? Colors.indigo : Colors.white60;

  Color get buttonColorCena => _selectedMeal.value == 'cena' ? Colors.indigo : Colors.white60;

  Color get buttonColorC_Lenta => _selectedMeal.value == 'caminata lenta' ? Colors.indigo : Colors.white60;

  Color get buttonColorC_Rapida => _selectedMeal.value == 'caminata rapida' ? Colors.indigo : Colors.white60;

  Color get buttonColorTrote => _selectedMeal.value == 'trote' ? Colors.indigo : Colors.white60;

  Color get buttonColorE_Guiado => _selectedMeal.value == 'ejercicio guiado' ? Colors.indigo : Colors.white60;


  Color get textColorDesayuno => _selectedMeal.value == 'desayuno' ? Colors.white : Colors.black87;

  Color get textColorAlmuerzo => _selectedMeal.value == 'almuerzo' ? Colors.white : Colors.black87;

  Color get textColorCena => _selectedMeal.value == 'cena' ? Colors.white : Colors.black87;

  Color get textColorC_Lenta => _selectedMeal.value == 'caminata lenta' ? Colors.white : Colors.black87;

  Color get textColorC_Rapida => _selectedMeal.value == 'caminata rapida' ? Colors.white : Colors.black87;

  Color get textColorTrote => _selectedMeal.value == 'trote' ? Colors.white : Colors.black87;

  Color get textColorE_Guiado => _selectedMeal.value == 'ejercicio guiado' ? Colors.white : Colors.black87;

  void datosAlimentacionTipo(String? user_id, String? tipo_alimento) async {
    _selectedMeal = ''.obs;
    try {
      isLoading(true);

      ResponseApi response = await _feedingProviders.datosEstadisticosTipo(user_id, tipo_alimento);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        datosAlimentacionT.assignAll(dataList.map((item) => item as Map<String, dynamic>).toList());

        if (datosAlimentacionT.isNotEmpty) {
          no.value = datosAlimentacionT.first['no_saludables'] ?? 0;
          si.value = datosAlimentacionT.first['si_saludables'] ?? 0;
          Get.forceAppUpdate();
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos por Tipo: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosEjercicio(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _exerciseProviders.datosEstadisticosE(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        datosEjercicioTipo.assignAll(dataList.map((item) => item as Map<String, dynamic>).toList());

        if (datosEjercicioTipo.isNotEmpty) {
          c_lenta.value = datosEjercicioTipo.first['caminata_lenta'] ?? 0;
          c_rapida.value = datosEjercicioTipo.first['caminata_rapida'] ?? 0;
          trote.value = datosEjercicioTipo.first['trote'] ?? 0;
          e_guiado.value = datosEjercicioTipo.first['ejercicio_guiado'] ?? 0;
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Ejercicio: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosEjercicioT(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _exerciseProviders.datosEjerciciosT(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

        List<Map<String, dynamic>> weeklyExercise = [];

        for (String day in daysOfWeek) {
          var exerciseData = dataMapped.firstWhere((element) => element['dia'] == day, orElse: () => {'minutos': 0});

          weeklyExercise.add({
            'fecha': exerciseData.containsKey('fecha') ? exerciseData['fecha'] : null,
            'minutos': exerciseData['minutos'],
            'dia': day,
          });
        }

        datosEjercicioTiempo.assignAll(weeklyExercise);
        print('Datos Ejercicios Tiempo: $datosEjercicioTiempo');
        Get.forceAppUpdate();
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Ejercicio de Tiempo: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosTipoEjercicio(String? user_id, String? tipo) async {
    try {
      isLoading(true);

      ResponseApi response = await _exerciseProviders.datosEjerciciosTipo(user_id, tipo);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

        List<Map<String, dynamic>> weeklyExercise = [];

        for (String day in daysOfWeek) {

          var exerciseData = dataMapped.firstWhere((element) => element['dia'] == day, orElse: () => {'minutos': 0});

          weeklyExercise.add({
            'fecha': exerciseData.containsKey('fecha') ? exerciseData['fecha'] : null,
            'minutos': exerciseData['minutos'],
            'dia': day,
          });
        }

        datosEjercicioTiempo.assignAll(weeklyExercise);
        Get.forceAppUpdate();
        print('Datos Tipo Ejercicio: $datosEjercicioTiempo');
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Tipo Ejercicio: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosEstadisticosAgua(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _waterProviders.datosEstadisticosAgua(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

        List<Map<String, dynamic>> weeklyWater = [];

        for (String day in daysOfWeek) {
          var waterData = dataMapped.firstWhere((element) => element['dia'] == day, orElse: () => {'cantidad_ml': 0});

          weeklyWater.add({
            'fecha': waterData.containsKey('fecha') ? waterData['fecha'] : null,
            'cantidad_ml': waterData['cantidad_ml'],
            'dia': day,
          });
        }

        datosAgua.assignAll(weeklyWater);
        print('Datos Estadísticos Agua: $datosAgua');
        Get.forceAppUpdate();
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadísticos Agua: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosEstatisticosDescanso(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _wake_upProviders.datosEstadisticosD(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        datosDescanso.assignAll(dataList.map((item) => item as Map<String, dynamic>).toList());

        if (datosDescanso.isNotEmpty) {
          bien.value = datosDescanso.first['descanso_bien'] ?? 0;
          mal.value = datosDescanso.first['descanso_mal'] ?? 0;
          print('Descanso: ${datosDescanso}');
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosSolTiempo(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _sunProviders.datosSol(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

        List<Map<String, dynamic>> weeklySun = [];

        for (String day in daysOfWeek) {
          var sunData = dataMapped.firstWhere((element) => element['dia'] == day, orElse: () => {'minutos': 0});

          weeklySun.add({
            'fecha': sunData.containsKey('fecha') ? sunData['fecha'] : null,
            'minutos': sunData['minutos'],
            'dia': day,
          });
        }

        datosSol.assignAll(weeklySun);
        print('Datos Sol Tiempo: $datosSol');
        Get.forceAppUpdate();
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Sol Tiempo: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosAireTiempo(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _airProviders.datosEstadisticosAire(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

        List<Map<String, dynamic>> weeklyAir = [];

        for (String day in daysOfWeek) {
          var airData = dataMapped.firstWhere((element) => element['dia'] == day, orElse: () => {'minutos': 0});

          weeklyAir.add({
            'fecha': airData.containsKey('fecha') ? airData['fecha'] : null,
            'minutos': airData['minutos'],
            'dia': day,
          });
        }

        datosAire.assignAll(weeklyAir);
        print('Datos Aire Tiempo: $datosAire');
        Get.forceAppUpdate();
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Aire Tiempo: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }


  void datosEsperanza(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _hopeProviders.datosEstadisticosHope(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        datosHope.assignAll(dataList.map((item) => item as Map<String, dynamic>).toList());

        if (datosHope.isNotEmpty) {
          oracion.value = datosHope.first['tipo_oracion'] ?? 0;
          l_biblia.value = datosHope.first['tipo_lectura'] ?? 0;
        }
        print('Datos Hope: ${datosHope}');
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos de Esperanza: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }
}
