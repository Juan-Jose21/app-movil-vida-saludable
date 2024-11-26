import 'package:app_vida_saludable/src/pages/bottom_bar/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controllers/informations_controller.dart';

class InformationsPage extends StatelessWidget {

  InformationsController con = Get.put(InformationsController());
  BottomBarController controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _miInformations(context),
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
            _cardFeeding(context),
            _cardExercise(context),
            _cardWater(context),
            _cardSun(context),
            _cardDream(context),
            _cardAire(context),
            _cardTemperancia(context),
            _cardHope(context),
          ],
        ),
      ),
    );
  }

  Widget _miInformations(BuildContext context) {
    return Obx(() {
      // Aquí obtienes los datos
      var datosFisicos = controller.datosFisicos.isNotEmpty ? controller.datosFisicos[0] : null;

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: 20,
          right: 20,
        ),
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Datos Iniciales',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5),
              Divider(thickness: 2, color: Colors.white),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Peso', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700)),
                  Text('Talla', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700)),
                  Text('IMC', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 5),
              datosFisicos != null
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${datosFisicos.peso} Kg', style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.w900)),
                  Text('${datosFisicos.altura} cm', style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.w900)),
                  Text('${datosFisicos.imc}', style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.w900)),
                ],
              )
                  : Center(
                child: Text('No hay datos disponibles', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      );
    });
  }



  Widget _cardFeeding(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () {
          con.showDevelopmentDialog(context);
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Dieta Saludable',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    'assets/img/alimentacion.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _cardFeeding(BuildContext context) {
  //   return Card(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
  //     elevation: 1,
  //     color: Colors.indigo[50],
  //     child: InkWell(
  //       onTap: () async {
  //         try {
  //           await _launchURL('https://quierovidaysalud.com/atitude/alimentacao/');
  //         } catch (e) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text(e.toString())),
  //           );
  //         }
  //       },
  //       child: SizedBox(
  //         height: 98,
  //         child: Row(
  //           children: <Widget>[
  //             Expanded(
  //               flex: 2,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 8.0),
  //                 child: RichText(
  //                   text: TextSpan(
  //                     children: [
  //                       TextSpan(
  //                         text: 'Dieta Saludable',
  //                         style: TextStyle(
  //                           color: Colors.black87,
  //                           fontSize: 22,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(right: 8.0),
  //                 child: Image.asset(
  //                   'assets/img/alimentacion.png',
  //                   fit: BoxFit.contain,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _cardExercise(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/ejercicios/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16.0), // Agrega padding a la derecha de la imagen
                  child: Image.asset(
                    'assets/img/ejercicio.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Haz ejercicio todos los días por salud',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se puede abrir $url';
    }
  }

  Widget _cardWater(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/agua/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Toma agua para una buena hidratación',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 85,
                    height: 85,
                    child: Image.asset(
                      'assets/img/agua.png',
                      fit: BoxFit.contain,
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


  Widget _cardSun(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/sol/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16.0), // Agrega padding a la derecha de la imagen
                  child: Image.asset(
                    'assets/img/imgSol.webp',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Es importante la toma de Vitamina D',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

  Widget _cardDream(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/descanso/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Descanso',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 85,
                    height: 85,
                    child: Image.asset(
                      'assets/img/descanso.png',
                      fit: BoxFit.contain,
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

  Widget _cardAire(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/aire-puro/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16.0), // Agrega padding a la derecha de la imagen
                  child: Image.asset(
                    'assets/img/aire_puro.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Aire Puro',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

  Widget _cardTemperancia(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/dominio-proprio/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Temperancia',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 85,
                    height: 85,
                    child: Image.asset(
                      'assets/img/temperancia.png',
                      fit: BoxFit.contain,
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

  Widget _cardHope(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      elevation: 1,
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () async {
          try {
            await _launchURL('https://quierovidaysalud.com/atitude/confianca/');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: SizedBox(
          height: 98,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                  child: SizedBox(
                    width: 85,
                    height: 85,
                    child: Image.asset(
                      'assets/img/ImgEsperanza.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Esperanza en Dios',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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


  Widget _textTitle(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.26),
      alignment: Alignment.topCenter,
      child: Text(
        'INFROMACIONES',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.black87,
        ),
      ),
    );
  }
}
