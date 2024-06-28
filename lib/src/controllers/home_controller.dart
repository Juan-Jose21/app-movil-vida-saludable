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

  // void settings() {
  //   Get.toNamed('/settings');
  // }

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
    scheduleMidnightReset();
  }

  void scheduleMidnightReset() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1);

    Duration durationUntilMidnight = midnight.difference(now);

    midnightTimer = Timer(durationUntilMidnight, () {
      resetPercentageWater();
      resetPercentageWaterC();
      resetPercentage();
      resetPercentageHope();
      resetPercentageSun();
      resetPercentageAir();
      resetPercentageDream();
      resetPercentageExercise();

      scheduleMidnightReset(); // Reschedule for the next day
    });
  }

  //SUBRI PORCENTAGE DE ALIMENTACION
  var percentageFeeding = 0.0.obs;

  void registerBreakfast() {
    if (percentageFeeding.value + 40 <= 100) {
      percentageFeeding.value += 40;
    }
  }

  void registerLunch() {
    if (percentageFeeding.value + 30 <= 100) {
      percentageFeeding.value += 30;
    }
  }

  void registerDinner() {
    if (percentageFeeding.value + 30 <= 100) {
      percentageFeeding.value += 30;
    }
  }

  void resetPercentage() {
    percentageFeeding.value = 0.0;
  }

  //SUBIR PORCENTAGE DE ESPERANZA

  var percentageHope = 0.0.obs;

  void registerOrar() {
    if (percentageHope.value + 50 <= 100) {
      percentageHope.value += 50;
    }
  }

    void registerLeerBiblia() {
    if (percentageHope.value + 50 <= 100) {
      percentageHope.value += 50;
    }
  }

  void resetPercentageHope() {
    percentageHope.value = 0.0;
  }

  //SUBIR PORCENTAGE DE DESCANSO

  var percentageDream = 0.0.obs;

  void registerDormir() {
    if (percentageDream.value + 50 <= 100) {
      percentageDream.value += 50;
    }
  }

  void registerDespertar() {
    if (percentageDream.value + 50 <= 100) {
      percentageDream.value += 50;
    }
  }

  void resetPercentageDream() {
    percentageDream.value = 0.0;
  }


  //SUBIR PORCENTAGE DE LUZ SOLAR

  var percentageSun = 0.0.obs;

  void registerSun() {
    if (percentageSun.value + 100 <= 100) {
      percentageSun.value += 100;
    }
  }

  void resetPercentageSun() {
    percentageSun.value = 0.0;
  }

  //SUBIR PORCENTAGE DE AIRE PURO

  var percentageAir = 0.0.obs;

  void registerAir() {
    if (percentageAir.value + 100 <= 100) {
      percentageAir.value += 100;
    }
  }

  void resetPercentageAir() {
    percentageAir.value = 0.0;
  }

  //SUBIR PORCENTAGE DE AGUA

  var percentageWater = 0.0.obs;

  void register1() {
    if (percentageWater.value + 12.5 <= 100) {
      percentageWater.value += 12.5;
    }
  }
  void resetPercentageWater() {
    percentageWater.value = 0.0;
  }

  //SUBIR PORCENTAGE DE AGUA

  var percentageWaterC = 0.0.obs;

  void registerC() {
    if (percentageWaterC.value + 250 <= 2000) {
      percentageWaterC.value += 250;
    }
  }
  void resetPercentageWaterC() {
    percentageWaterC.value = 0.0;
  }

  //SUBIR PORCENTAGE DE EJERCICIO

  var percentageExercise = 0.0.obs;

  void registerExercise() {
    if (percentageExercise.value + 100 <= 100) {
      percentageExercise.value += 100;
    }
  }
  void resetPercentageExercise() {
    percentageExercise.value = 0.0;
  }

  @override
  void onClose() {
    midnightTimer?.cancel();
    super.onClose();
  }
}
