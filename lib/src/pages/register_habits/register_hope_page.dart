import 'package:app_vida_saludable/src/controllers/register_hope_controller.dart';
import 'package:app_vida_saludable/src/utils/custom_paint_hope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/home_controller.dart';

class RegisterHopePage extends StatelessWidget {

  final RegisterHopeController controller = Get.put(RegisterHopeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.indigo,
        child: Stack(
          children: [
            _iconBack(context),
            Column(
              children: [
                _textTitle(),
                _bgForm(context),
              ],
            ),
            _cardRecomendacion(context),
            _formHope(context)
          ],
        ),
      ),
    );
  }


  Widget _bgForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.77,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(25, 25),
            bottomRight: Radius.elliptical(25, 25),
          )
      ),
    );
  }

  Widget _textTitle() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Text(
        'Esperanza',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _iconBack(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 34),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Card _cardRecomendacion(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.12,
        left: 25,
        right: 25,
      ),
      elevation: 1,
      color: Colors.indigo[50],
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/img/esperanza_paloma.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 220), // Limitar el ancho del texto
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          child: Text(
                            'Se recomienda orar tres veces al día: antes de Desayunar, Almorzar y Cenar.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _formHope(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _circleProgres(context),
            _cardOrar(context),
            _cardBiblia(context)
          ],
        ),
      ),
    );
  }

  Widget _circleProgres(BuildContext context) {
    HomeController con = Get.find<HomeController>();

    double percentage = con.percentageHope.value;

    return Container(
      child: CircularProgressHope(percentage: percentage),
    );

  }

  Card _cardOrar(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: 25,
        right: 25,
      ),
      elevation: 1,
      color: Colors.indigo[100],
      child: GestureDetector(
        onTap: () {
          controller.pressed('oracion');
          controller.createHope();
          Navigator.pop(context);
        },
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/img/ImgEsperanza.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Orar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('Hora recomendable 08:00', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Card _cardBiblia(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: 25,
        right: 25,
      ),
      elevation: 1,
      color: Colors.indigo[100],
      child: GestureDetector(
        onTap: () {
          controller.pressed('lectura biblica');
          controller.createHope();
          Navigator.pop(context);
        },
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/img/biblia.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Leer la Biblia', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('Hora recomendable 08:00', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
