import 'package:app_vida_saludable/src/providers/air_providers.dart';
import 'package:app_vida_saludable/src/providers/exercise_providers.dart';
import 'package:app_vida_saludable/src/providers/feeding_providers.dart';
import 'package:app_vida_saludable/src/providers/hope_providers.dart';
import 'package:app_vida_saludable/src/providers/sleep_providers.dart';
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
  SleepProviders _sleepProviders = SleepProviders();
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

  var datosDescansoHorasU = <Map<String, dynamic>>[].obs;

  var datosSol = <Map<String, dynamic>>[].obs;

  var datosAire = <Map<String, dynamic>>[].obs;

  var datosHope = <Map<String, dynamic>>[].obs;

  StatisticsController() {
    // print('USUARIO DE SESSION: ${user.toJson()}');
    // datosAlimentacion(user.id.toString());
    // Get.forceAppUpdate();
  }

  void datosAlimentacion(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _feedingProviders.datosEstadisticos(user_id);

      if (response.success == true) {
        Map<String, dynamic> data = response.data ?? {};
        no.value = (data['no_saludables'] ?? 0.0).toInt();
        si.value = (data['si_saludables'] ?? 0.0).toInt();

      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos: $e');
    } finally {
      isLoading(false);
    }
  }

  void onPressed(String meal) {
    _selectedMeal.value = meal;
  }

  Color get buttonColorDesayuno =>
      _selectedMeal.value == 'desayuno' ? Colors.indigo : Colors.white60;

  Color get buttonColorAlmuerzo =>
      _selectedMeal.value == 'almuerzo' ? Colors.indigo : Colors.white60;

  Color get buttonColorCena =>
      _selectedMeal.value == 'cena' ? Colors.indigo : Colors.white60;

  Color get buttonColorC_Lenta =>
      _selectedMeal.value == 'caminata lenta' ? Colors.indigo : Colors.white60;

  Color get buttonColorC_Rapida =>
      _selectedMeal.value == 'caminata rapida' ? Colors.indigo : Colors.white60;

  Color get buttonColorTrote =>
      _selectedMeal.value == 'trote' ? Colors.indigo : Colors.white60;

  Color get buttonColorE_Guiado =>
      _selectedMeal.value == 'ejercicio guiado' ? Colors.indigo : Colors
          .white60;


  Color get textColorDesayuno =>
      _selectedMeal.value == 'desayuno' ? Colors.white : Colors.black87;

  Color get textColorAlmuerzo =>
      _selectedMeal.value == 'almuerzo' ? Colors.white : Colors.black87;

  Color get textColorCena =>
      _selectedMeal.value == 'cena' ? Colors.white : Colors.black87;

  Color get textColorC_Lenta =>
      _selectedMeal.value == 'caminata lenta' ? Colors.white : Colors.black87;

  Color get textColorC_Rapida =>
      _selectedMeal.value == 'caminata rapida' ? Colors.white : Colors.black87;

  Color get textColorTrote =>
      _selectedMeal.value == 'trote' ? Colors.white : Colors.black87;

  Color get textColorE_Guiado =>
      _selectedMeal.value == 'ejercicio guiado' ? Colors.white : Colors.black87;

  void datosAlimentacionTipo(String? user_id, String? tipo_alimento) async {
    _selectedMeal = ''.obs; // Reinicia el valor de _selectedMeal
    try {
      isLoading(true);

      // Llamada a la API
      ResponseApi response = await _feedingProviders.datosEstadisticosTipo(user_id, tipo_alimento);

      if (response.success == true) {
        // Verifica si `response.data` es un mapa en lugar de una lista
        if (response.data is Map<String, dynamic>) {
          // Asigna directamente el mapa de datos a `datosAlimentacionT`
          datosAlimentacionT.assignAll([response.data as Map<String, dynamic>]);

          // Asigna valores convertidos a enteros si `datosAlimentacionT` no está vacío
          if (datosAlimentacionT.isNotEmpty) {
            no.value = (datosAlimentacionT.first['no_saludables'] ?? 0.0).toInt();
            si.value = (datosAlimentacionT.first['si_saludables'] ?? 0.0).toInt();
            Get.forceAppUpdate(); // Actualiza la UI si es necesario
          }
        } else {
          // Si `data` no es un mapa válido, muestra un error
          Get.snackbar('Error', 'Formato de datos inesperado');
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos por Tipo: $e');
    } finally {
      isLoading(false);
    }
  }


  void datosEjercicio(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _exerciseProviders.datosEstadisticosE(user_id);

      if (response.success == true) {
        Map<String, dynamic> data = response.data ?? {};

        // Asignar los valores directamente desde el mapa
        c_lenta.value = data['caminata_lenta'] ?? 0;
        c_rapida.value = data['caminata_rapida'] ?? 0;
        trote.value = data['trote'] ?? 0;
        e_guiado.value = data['ejercicio_guiado'] ?? 0;

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

        List<Map<String, dynamic>> dataMapped = dataList.map((
            item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = [
          'Dom',
          'Lun',
          'Mar',
          'Mié',
          'Jue',
          'Vie',
          'Sáb'
        ];

        List<Map<String, dynamic>> weeklyExercise = [];

        for (String day in daysOfWeek) {
          var exerciseData = dataMapped.firstWhere((
              element) => element['dia_semana'] == day, orElse: () => {'tiempo_total': 0});

          weeklyExercise.add({
            'fecha_dia': exerciseData.containsKey('fecha_dia')
                ? exerciseData['fecha_dia']
                : null,
            'tiempo_total': exerciseData['tiempo_total'],
            'dia_semana': day,
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

      ResponseApi response = await _exerciseProviders.datosEjerciciosTipo(
          user_id, tipo);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((
            item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = [
          'Dom',
          'Lun',
          'Mar',
          'Mié',
          'Jue',
          'Vie',
          'Sáb'
        ];

        List<Map<String, dynamic>> weeklyExercise = [];

        for (String day in daysOfWeek) {
          var exerciseData = dataMapped.firstWhere((
              element) => element['dia_semana'] == day, orElse: () => {'tiempo_total': 0});

          weeklyExercise.add({
            'fecha_dia': exerciseData.containsKey('fecha_dia')
                ? exerciseData['fecha_dia']
                : null,
            'tiempo_total': exerciseData['tiempo_total'],
            'dia_semana': day,
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

      ResponseApi response = await _waterProviders.datosEstadisticosAgua(
          user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((
            item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = [
          'Dom',
          'Lun',
          'Mar',
          'Mié',
          'Jue',
          'Vie',
          'Sáb'
        ];

        List<Map<String, dynamic>> weeklyWater = [];

        for (String day in daysOfWeek) {
          var waterData = dataMapped.firstWhere((
              element) => element['dia_semana'] == day,
              orElse: () => {'cantidad_agua': 0});

          weeklyWater.add({
            'fecha_dia': waterData.containsKey('fecha_dia')
                ? waterData['fecha_dia']
                : null,
            'cantidad_agua': waterData['cantidad_agua'],
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

      ResponseApi response = await _wake_upProviders.datosEstadisticosD(
          user_id);

      if (response.success == true) {
        Map<String, dynamic> dataMap = response.data ?? {}; // Obtener el Map

        // Convertir los valores de double a int antes de asignar
        bien.value = (dataMap['descanso_bien'] ?? 0).toInt(); // Convertir a int
        mal.value = (dataMap['descanso_mal'] ?? 0).toInt(); // Convertir a int

        // Imprimir el mapa completo para depuración
        print('Descanso: $dataMap');
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Descanso: $e');
      // Get.snackbar('Error', 'Error desconocido');
    } finally {
      isLoading(false);
    }
  }

  void datosEstadisticosDescansoHoras(String? user_id) async {
    try {
      isLoading(true);

      ResponseApi response = await _sleepProviders.datosDescansoHorasT(user_id);

      if (response.success == true) {
        List<dynamic> dataList = response.data ?? [];

        List<Map<String, dynamic>> dataMapped = dataList.map((
            item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = [
          'Dom',
          'Lun',
          'Mar',
          'Mié',
          'Jue',
          'Vie',
          'Sáb'
        ];

        List<Map<String, dynamic>> weeklySun = [];

        for (String day in daysOfWeek) {
          var sunData = dataMapped.firstWhere((
              element) => element['dia_semana'] == day,
              orElse: () => {'total_horas': 0});

          weeklySun.add({
            'fecha_dia': sunData.containsKey('fecha_dia')
                ? sunData['fecha_dia']
                : null,
            'total_horas': sunData['total_horas'],
            'dia_semana': day,
          });
        }

        datosDescansoHorasU.assignAll(weeklySun);
        print('Datos Descanso Horas: $datosDescansoHorasU');
        Get.forceAppUpdate();
      } else {
        Get.snackbar('Error', response.message ?? 'Datos no obtenidos de Descanso Horas');
      }
    } catch (e) {
      print('Error en mostrar datos Estadisticos Descanso Horas: $e');
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

        List<Map<String, dynamic>> dataMapped = dataList.map((
            item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = [
          'Dom',
          'Lun',
          'Mar',
          'Mié',
          'Jue',
          'Vie',
          'Sáb'
        ];

        List<Map<String, dynamic>> weeklySun = [];

        for (String day in daysOfWeek) {
          var sunData = dataMapped.firstWhere((
              element) => element['dia_semana'] == day,
              orElse: () => {'tiempo_total': 0});

          weeklySun.add({
            'fecha_dia': sunData.containsKey('fecha_dia')
                ? sunData['fecha_dia']
                : null,
            'tiempo_total': sunData['tiempo_total'],
            'dia_semana': day,
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

        List<Map<String, dynamic>> dataMapped = dataList.map((
            item) => item as Map<String, dynamic>).toList();

        List<String> daysOfWeek = [
          'Dom',
          'Lun',
          'Mar',
          'Mié',
          'Jue',
          'Vie',
          'Sáb'
        ];

        List<Map<String, dynamic>> weeklyAir = [];

        for (String day in daysOfWeek) {
          var airData = dataMapped.firstWhere((
              element) => element['dia_semana'] == day,
              orElse: () => {'tiempo_total': 0});

          weeklyAir.add({
            'fecha_dia': airData.containsKey('fecha_dia')
                ? airData['fecha_dia']
                : null,
            'tiempo_total': airData['tiempo_total'],
            'dia_semana': day,
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
        if (response.data is List) {
          List<dynamic> dataList = response.data;

          datosHope.assignAll(dataList.map((item) => item as Map<String, dynamic>).toList());

          if (datosHope.isNotEmpty) {
            // Asegúrate de convertir a int desde double
            oracion.value = (datosHope.first['tipo_oracion'] ?? 0).toInt();
            l_biblia.value = (datosHope.first['tipo_lectura'] ?? 0).toInt();
          }
        } else if (response.data is Map) {
          Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
          datosHope.assignAll([dataMap]); // Envuelve el mapa en una lista

          oracion.value = (dataMap['tipo_oracion'] ?? 0).toInt();
          l_biblia.value = (dataMap['tipo_lectura'] ?? 0).toInt();
        } else {
          Get.snackbar('Error', 'Formato de datos inesperado');
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
