import 'package:app_vida_saludable/src/utils/popup_feeding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_vida_saludable/src/models/user.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  User user = User.fronJson(GetStorage().read('User') ?? {});

  final box = GetStorage();

  var percentageFeeding = 0.0.obs;
  var percentageHope = 0.0.obs;
  var percentageDream = 0.0.obs;
  var percentageSun = 0.0.obs;
  var percentageAir = 0.0.obs;
  var percentageWater = 0.0.obs;
  var percentageWaterC = 0.0.obs;
  var percentageExercise = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    try {
      final userData = GetStorage().read('User');
      if (userData != null) {
        user = User.fronJson(userData);
        update(); // Esto forzará la actualización de la UI
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }
  HomeController() {
    _loadPercentagesFromStorage();
  }

  void _loadPercentagesFromStorage() {
    percentageFeeding.value = box.read('percentageFeeding') ?? 0.0;
    percentageHope.value = box.read('percentageHope') ?? 0.0;
    percentageDream.value = box.read('percentageDream') ?? 0.0;
    percentageSun.value = box.read('percentageSun') ?? 0.0;
    percentageAir.value = box.read('percentageAir') ?? 0.0;
    percentageWater.value = box.read('percentageWater') ?? 0.0;
    percentageWaterC.value = box.read('percentageWaterC') ?? 0.0;
    percentageExercise.value = box.read('percentageExercise') ?? 0.0;
  }

  void resetAllPercentages() {
    box.remove('percentageFeeding');
    box.remove('percentageHope');
    box.remove('percentageDream');
    box.remove('percentageSun');
    box.remove('percentageAir');
    box.remove('percentageWater');
    box.remove('percentageWaterC');
    box.remove('percentageExercise');

    _loadPercentagesFromStorage();
    update();
  }

  // SUBIR PORCENTAJE DE ALIMENTACION
  void registerBreakfast() {
    if (percentageFeeding.value + 40 <= 100) {
      percentageFeeding.value += 40;
      _savePercentageFeeding();
    }
  }

  void registerLunch() {
    if (percentageFeeding.value + 30 <= 100) {
      percentageFeeding.value += 30;
      _savePercentageFeeding();
    }
  }

  void registerDinner() {
    if (percentageFeeding.value + 30 <= 100) {
      percentageFeeding.value += 30;
      _savePercentageFeeding();
    }
  }

  void resetPercentage() {
    percentageFeeding.value = 0.0;
    _savePercentageFeeding();
  }

  void _savePercentageFeeding() {
    box.write('percentageFeeding', percentageFeeding.value);
  }

  // SUBIR PORCENTAJE DE ESPERANZA
  void registerOrar() {
    if (percentageHope.value + 50 <= 100) {
      percentageHope.value += 50;
      _savePercentageHope();
    }
  }

  void registerLeerBiblia() {
    if (percentageHope.value + 50 <= 100) {
      percentageHope.value += 50;
      _savePercentageHope();
    }
  }

  void resetPercentageHope() {
    percentageHope.value = 0.0;
    _savePercentageHope();
  }

  void _savePercentageHope() {
    box.write('percentageHope', percentageHope.value);
  }

  // SUBIR PORCENTAJE DE DESCANSO
  void registerDormir() {
    if (percentageDream.value + 50 <= 100) {
      percentageDream.value += 50;
      _savePercentageDream();
    }
  }

  void registerDespertar() {
    if (percentageDream.value + 50 <= 100) {
      percentageDream.value += 50;
      _savePercentageDream();
    }
  }

  void resetPercentageDream() {
    percentageDream.value = 0.0;
    _savePercentageDream();
  }

  void _savePercentageDream() {
    box.write('percentageDream', percentageDream.value);
  }

  // SUBIR PORCENTAJE DE LUZ SOLAR
  void registerSun() {
    if (percentageSun.value + 100 <= 100) {
      percentageSun.value += 100;
      _savePercentageSun();
    }
  }

  void resetPercentageSun() {
    percentageSun.value = 0.0;
    _savePercentageSun();
  }

  void _savePercentageSun() {
    box.write('percentageSun', percentageSun.value);
  }

  // SUBIR PORCENTAJE DE AIRE PURO
  void registerAir() {
    if (percentageAir.value + 100 <= 100) {
      percentageAir.value += 100;
      _savePercentageAir();
    }
  }

  void resetPercentageAir() {
    percentageAir.value = 0.0;
    _savePercentageAir();
  }

  void _savePercentageAir() {
    box.write('percentageAir', percentageAir.value);
  }

  // SUBIR PORCENTAJE DE AGUA
  void register1() {
    if (percentageWater.value + 12.5 <= 100) {
      percentageWater.value += 12.5;
      _savePercentageWater();
    }
  }

  void resetPercentageWater() {
    percentageWater.value = 0.0;
    _savePercentageWater();
  }

  void _savePercentageWater() {
    box.write('percentageWater', percentageWater.value);
  }

  // SUBIR PORCENTAJE DE AGUA
  void registerC() {
    if (percentageWaterC.value + 250 <= 2000) {
      percentageWaterC.value += 250;
      _savePercentageWaterC();
    }
  }

  void resetPercentageWaterC() {
    percentageWaterC.value = 0.0;
    _savePercentageWaterC();
  }

  void _savePercentageWaterC() {
    box.write('percentageWaterC', percentageWaterC.value);
  }

  // SUBIR PORCENTAJE DE EJERCICIO
  void registerExercise() {
    if (percentageExercise.value + 100 <= 100) {
      percentageExercise.value += 100;
      _savePercentageExercise();
    }
  }

  void resetPercentageExercise() {
    percentageExercise.value = 0.0;
    _savePercentageExercise();
  }

  void _savePercentageExercise() {
    box.write('percentageExercise', percentageExercise.value);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showInfoFeeding(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoFeeding();
      },
    );
  }

  void showInfoExercise(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoExcercise();
      },
    );
  }

  void showInfoHope(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoHope();
      },
    );
  }

  void showInfoWater(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoWater();
      },
    );
  }

  void showInfoDream(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoDream();
      },
    );
  }

  void showInfoSun(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoSun();
      },
    );
  }

  void showInfoAir(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoAire();
      },
    );
  }
}
