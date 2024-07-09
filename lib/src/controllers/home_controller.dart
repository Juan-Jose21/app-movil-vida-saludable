import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_vida_saludable/src/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:app_vida_saludable/src/utils/popup_feeding.dart';

class HomeController extends GetxController {
  User user = User.fronJson(GetStorage().read('User') ?? {});

  HomeController() {
    // print('USUARIO DE SESSION: ${user.toJson()}');
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

  void showInfoAire(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoAire();
      },
    );
  }

  Timer? midnightTimer;

  @override
  void onInit() {
    super.onInit();
    percentageFeeding.value = boxFeeding.read('percentageFeeding') ?? 0.0;
    percentageHope.value = boxHope.read('percentageHope') ?? 0.0;
    percentageDream.value = boxDream.read('percentageDream') ?? 0.0;
    percentageSun.value = boxSun.read('percentageSun') ?? 0.0;
    percentageAir.value = boxAir.read('percentageAir') ?? 0.0;
    percentageWater.value = boxWater.read('percentageWater') ?? 0.0;
    percentageWaterC.value = boxWaterC.read('percentageWaterC') ?? 0.0;
    percentageExercise.value = boxExercise.read('percentageExercise') ?? 0.0;
    scheduleMidnightReset();

  }

  void scheduleMidnightReset() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1);

    Duration durationUntilMidnight = midnight.difference(now);

    midnightTimer = Timer(durationUntilMidnight, () {
      resetAllPercentages();
      scheduleMidnightReset();
    });
  }

  void resetAllPercentages() {
    resetPercentageWater();
    resetPercentageWaterC();
    resetPercentage();
    resetPercentageHope();
    resetPercentageSun();
    resetPercentageAir();
    resetPercentageDream();
    resetPercentageExercise();

    boxFeeding.remove('percentageFeeding');
    boxHope.remove('percentageHope');
    boxDream.remove('percentageDream');
    boxSun.remove('percentageSun');
    boxAir.remove('percentageAir');
    boxWater.remove('percentageWater');
    boxWaterC.remove('percentageWaterC');
    boxExercise.remove('percentageExercise');
  }


  //SUBRI PORCENTAGE DE ALIMENTACION
  var percentageFeeding = 0.0.obs;
  final boxFeeding = GetStorage();

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
    boxFeeding.write('percentageFeeding', percentageFeeding.value);
  }

  //SUBIR PORCENTAGE DE ESPERANZA
  var percentageHope = 0.0.obs;
  final boxHope = GetStorage();


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
    boxHope.write('percentageHope', percentageHope.value);
  }
  //SUBIR PORCENTAGE DE DESCANSO

  var percentageDream = 0.0.obs;
  final boxDream = GetStorage();

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
    boxDream.write('percentageDream', percentageDream.value);
  }

  //SUBIR PORCENTAGE DE LUZ SOLAR

  var percentageSun = 0.0.obs;
  final boxSun = GetStorage();

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
    boxSun.write('percentageSun', percentageSun.value);
  }

  //SUBIR PORCENTAGE DE AIRE PURO

  var percentageAir = 0.0.obs;
  final boxAir = GetStorage();

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
    boxAir.write('percentageAir', percentageAir.value);
  }

  //SUBIR PORCENTAGE DE AGUA

  var percentageWater = 0.0.obs;
  final boxWater = GetStorage();

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
    boxWater.write('percentageWater', percentageWater.value);
  }

  //SUBIR PORCENTAGE DE AGUA
  var percentageWaterC = 0.0.obs;
  final boxWaterC = GetStorage();

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
    boxWaterC.write('percentageWaterC', percentageWaterC.value);
  }

  //SUBIR PORCENTAGE DE EJERCICIO
  var percentageExercise = 0.0.obs;
  final boxExercise = GetStorage();

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
    boxExercise.write('percentageExercise', percentageExercise.value);
  }

  @override
  void onClose() {
    midnightTimer?.cancel();
    super.onClose();
  }
}
