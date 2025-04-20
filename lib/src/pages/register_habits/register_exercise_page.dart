import 'package:app_vida_saludable/src/controllers/pedometer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/register_exercise_controller.dart';

class RegisterExercisePage extends StatelessWidget {

  final RegisterExerciseController controller = Get.put(RegisterExerciseController());
  final PedometerController pedometerController = Get.find<PedometerController>();

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
  Widget _cardPodometro(BuildContext context) {
    return Obx(() => Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.14,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _metricCircle(
            icon: Icons.directions_walk,
            value: pedometerController.steps.value.toString(),
            unit: 'Pasos',
            color: Colors.blue[800]!,
          ),
          _metricCircle(
            icon: Icons.local_fire_department,
            value: pedometerController.calories.value.toStringAsFixed(1),
            unit: 'Calorías',
            color: Colors.orange[700]!,
          ),
          _metricCircle(
            icon: Icons.alt_route,
            value: (pedometerController.distance.value / 1000).toStringAsFixed(1),
            unit: 'Kilómetros',
            color: Colors.green[700]!,
          ),
        ],
      ),
    ));
  }
  Widget _metricCircle({
    required IconData icon,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.4), width: 1.5),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 28),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          unit,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _formFeeding(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29, left: 25, right: 25),
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
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: Size(150, 0),
        ),

        child: Text(
          'Caminata Lenta',
          style: TextStyle(
            fontSize: 16,
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
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(150, 0),
      ),
      child: Text(
        'Caminata Rápida',
        style: TextStyle(
          fontSize: 16,
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
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(150, 0),
      ),
      child: Text(
        'Trote',
        style: TextStyle(
          fontSize: 16,
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
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(150, 0),
      ),
      child: Text(
        'Ejercicio Guiado',
        style: TextStyle(
          fontSize: 16,
          color: controller.textColorOtro,
        ),
      ),
    ),
    );
  }

Widget _infoCronometro(BuildContext context) {
  final controller = Get.find<RegisterExerciseController>();
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Checkboxes (mantén tu código actual)
      Container(
        padding: const EdgeInsets.only(left: 4.0),
        child: Row(
          children: [
            Obx(() => Row(
              children: [
                Checkbox(
                  value: controller.luzSolar.value,
                  onChanged: (value) => controller.luzSolar.value = value ?? false,
                  activeColor: Colors.indigo,
                ),
                Text('Luz solar'),
                SizedBox(width: 45),
              ],
            )),
            Obx(() => Row(
              children: [
                Checkbox(
                  value: controller.airePuro.value,
                  onChanged: (value) => controller.airePuro.value = value ?? false,
                  activeColor: Colors.indigo,
                ),
                Text('Aire puro'),
              ],
            )),
          ],
        ),
      ),
      SizedBox(height: 12),
      
      // Título del cronómetro
      Text(
        'Cronómetro',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      SizedBox(height: 8),
      
      // Cronómetro centrado
      Center(
        child: Obx(() => Text(
          controller.formattedTime.value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )),
      ),
      SizedBox(height: 8),
      _buttomsCronometro(context),
    ],
  );
}

Widget _buttomsCronometro(BuildContext context) {
  final controller = Get.find<RegisterExerciseController>();
  
  return Obx(() => Container( // Envuelve en Obx
    margin: EdgeInsets.only(top: 8),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botón Play
        IconButton(
          onPressed: controller.isTimerRunning ? null : controller.startTimer,
          icon: Icon(
            Icons.play_circle, 
            size: 35,
            color: controller.isTimerRunning ? Colors.grey : Colors.indigo,
          ),
        ),
        SizedBox(width: 20),
        
        // Botón Pause
        IconButton(
          onPressed: controller.isTimerRunning ? controller.pauseTimer : null,
          icon: Icon(
            Icons.pause_circle, 
            size: 35,
            color: controller.isTimerRunning ? Colors.red : Colors.grey,
          ),
        ),
        SizedBox(width: 20),
        
        // Botón Reset
        IconButton(
          onPressed: controller.resetTimer,
          icon: Icon(
            Icons.replay_circle_filled, 
            size: 35,
            color: Colors.green,
          ),
        ),
      ],
    ),
  ));
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
        controller.submitData();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(150, 0),
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
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        minimumSize: Size(150, 0),
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
