import 'package:app_vida_saludable/src/controllers/register_feeding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/register_exercise_controller.dart';

class RegisterExercisePage extends StatelessWidget {

  final RegisterExerciseController controller = Get.put(RegisterExerciseController());

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
            _cardPodometro(context),
            _formFeeding(context)
          ],
        ),
      ),
    );
  }


  Widget _bgForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(25, 25),
            topRight: Radius.elliptical(25, 25),
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
        'Ejercicio',
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
      margin: EdgeInsets.only(left: 16, top: 34), // Margen a la izquierda del icono
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

  Card _cardPodometro(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 25,
        right: 25,
      ),
      elevation: 1,
      color: Colors.indigo[50],
      child: SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Padding(
                //   padding: EdgeInsets.all(10),
                //   child: Image.asset(
                //     'assets/img/esperanza_paloma.png',
                //     width: 60,
                //     height: 60,
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 250), // Limitar el ancho del texto
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          // child: Text(
                          //   'Se recomienda orar tres veces al día: antes de Desayunar, Almorzar y Cenar.',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 14,
                          //   ),
                          //   softWrap: true,
                          // ),
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

  Widget _formFeeding(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 25, right: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _inputDate(context),
            SizedBox(height: 15),
            _buttonTypeFeeding(),
            SizedBox(height: 15),
            _infoCronometro(context),
            SizedBox(height: 15),
            _buttoms(context),
          ],
        ),
      ),
    );
  }

  Widget _inputDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1),
        GestureDetector(
          onTap: () async {
            await controller.selectDate();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Obx(
                  () => TextField(
                enabled: false,
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(controller.currentDateTime),
                ),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  suffixIcon: Icon(Icons.date_range, color: Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonTypeFeeding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de ejercicio',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54
          ),
        ),
        SizedBox(height: 1), // Espacio entre el texto y los botones
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buttomCaminataL(),
                  _buttomAlmuerzo(),

                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buttomCena(),
                  _buttomOtro(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttomCaminataL() {
    return Obx(
          () => ElevatedButton(
        onPressed: () {
          controller.onPressed('caminata lenta');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.buttonColorDesayuno,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),

        child: Text(
          'Caminata Lenta',
          style: TextStyle(
            fontSize: 20,
            color: controller.textColorDesayuno,
          ),
        ),
      ),
    );
  }

  Widget _buttomAlmuerzo() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        controller.onPressed('caminata rapida');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorAlmuerzo,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Caminata Rápida',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorAlmuerzo,
        ),
      ),
    ),
    );
  }

  Widget _buttomCena() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        controller.onPressed('trote');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorCena,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 57),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Trote',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorCena,
        ),
      ),
    ),
    );
  }

  Widget _buttomOtro() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        controller.onPressed('ejercicio guiado');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorOtro,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Ejercicio Guiado',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorOtro,
        ),
      ),
    ),
    );
  }

  Widget _infoCronometro(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Cronometro',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            // Obx(() => Text(
            //   // 'Acumulado: ${con.formattedTime}',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black54,
            //   ),
            // )),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Obx(() => Text(
                controller.formattedTime,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
              SizedBox(height: 8),
            ],
          ),
        ),
        _buttomsCronometro(context),
      ],
    );
  }

  Widget _buttomsCronometro(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _butomsC(context),
        ],
      ),
    );
  }

  Widget _butomsC(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: controller.startTimer,
                child: Icon(Icons.play_circle, color: Colors.indigo, size: 35),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: controller.pauseTimer,
                child: Icon(Icons.pause_circle, color: Colors.red, size: 35),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: controller.resetTimer,
                child: Icon(Icons.replay_circle_filled, color: Colors.green, size: 35),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttoms(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buttomCancel(context),
          _buttomGuard(context)
        ],
      ),
    );
  }


  Widget _buttomGuard(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.createExercise();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Guardar',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buttomCancel(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Cancelar',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

}
