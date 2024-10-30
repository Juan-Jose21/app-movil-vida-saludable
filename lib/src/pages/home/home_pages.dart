import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_exercise_page.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_hope_page.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_sun_page.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_water_pages.dart';
import 'package:app_vida_saludable/src/pages/settins/profile.dart';
import 'package:app_vida_saludable/src/utils/custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:app_vida_saludable/src/pages/register_habits/register_feeding.dart';
import 'package:get/get.dart';

import '../register_habits/register_air_page.dart';
import '../register_habits/register_dream_page.dart';
import '../statistics/statistics_page.dart';

class HomePage extends GetView<HomeController> {

  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Forzar actualización al entrar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadUserData();
    });

    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<HomeController>( // Envolver con GetBuilder para actualización automática
            builder: (con) => _miProfile(context, con),
          ),
          _textTitle(context),
          _scrollHabits(context)
        ],
      ),
    );
  }


  Widget _scrollHabits(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _cardWater(context),
            _cardDream(context),
            _cardExercise(context),
            _cardSun(context),
            _cardAire(context),
            _cardFeeding(context),
            _cardTemperancia(context),
            _cardHope(context),
          ],
        ),
      ),
    );
  }

  Card _miProfile(BuildContext context, HomeController con) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).size.height * 0.08),
      elevation: 1,
      color: Colors.indigo,
      child: SizedBox(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 55,
                height: 55,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/img/profile.png'),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${con.user.nombre ?? ""}',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${con.user.correo ?? ""}',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'VIDA SALUDABLE',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ProfilePage()); // Usar Get.to en lugar de Navigator
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_forward_sharp, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx _cardFeeding(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterFeedingPage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'N',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'utrición',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/alimentacion.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageFeeding.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoFeeding(context);
              },
            ),
          ),
        ],
      );
    });
  }


  Obx _cardExercise(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterExercisePage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'E',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'jercicio',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/ejercicio.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageExercise.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoFeeding(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Obx _cardWater(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterWaterPage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'A',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'gua',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/agua.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageWater.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoWater(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Obx _cardDream(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Get.forceAppUpdate();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterDreamPage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'D',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'escanso',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/descanso.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageDream.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoDream(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Obx _cardHope(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterHopePage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'E',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'speranza',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/ImgEsperanza.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageHope.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoHope(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Obx _cardSun(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterSunPage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'L',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'uz Solar',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/imgSol.webp',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageSun.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoSun(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Obx _cardAire(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterAirPage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'A',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'ire Puro',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/aire_puro.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageAir.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoAir(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Obx _cardTemperancia(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    return Obx(() {
      return Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            elevation: 1,
            color: Colors.indigo[50],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsPage()),
                );
              },
              child: SizedBox(
                height: 98,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'T',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'emperancia',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 90,
                        height: 90,
                        child: Image.asset(
                          'assets/img/temperancia.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Lógica para registrar el desayuno, almuerzo o cena
                            // Ejemplo: con.registerBreakfast();
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: CircularProgressBar(
                                  percentage: con.percentageAir.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 17,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                con.showInfoAir(context);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _textTitle(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.26),
      alignment: Alignment.topCenter,
      child: Text(
        'HÁBITOS SALUDABLES',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Colors.black87,
        ),
      ),
    );
  }


}
