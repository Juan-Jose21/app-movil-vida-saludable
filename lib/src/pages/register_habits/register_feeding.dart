import 'package:app_vida_saludable/src/controllers/register_feeding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterFeedingPage extends StatelessWidget {

  final RegisterFeedingController controller = Get.put(RegisterFeedingController());

  bool desayunoRegistrado = false;

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
        'Alimentación',
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

  Widget _formFeeding(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, left: 25, right: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _inputDate(context),
            SizedBox(height: 15),
            _inputTime(context),
            SizedBox(height: 15),
            _buttonTypeFeeding(),
            SizedBox(height: 15),
            _buttonSaludable(),
            SizedBox(height: 50),
            _buttoms(context)
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
            // Agregar aquí la lógica para seleccionar la fecha
            await controller.selectDate();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: TextField(
              enabled: false, // Bloquea la entrada de texto
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
      ],
    );
  }

  Widget _inputTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hora',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1),
        GestureDetector(
          onTap: () async {
            await controller.selectTime();
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
                  text: DateFormat('HH:mm:ss').format(controller.currentDateTime),
                ),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  suffixIcon: Icon(Icons.access_time, color: Colors.black87),
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
          'Tipo de alimento',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54
          ),
        ),
        SizedBox(height: 1),
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buttomDesayuno(),
                  _buttomAlmuerzo(),
                  _buttomCena(),
                ],
              ),
              SizedBox(height: 8),
              _buttomOtro(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttomDesayuno() {
    final bool isHoraPasada = controller.isHoraPasada.value;
    print('Vista: ${controller.isHoraPasada.value}');

    return Obx(() => ElevatedButton(
      onPressed: isHoraPasada
          ? null
          : () {
        controller.onPressed('desayuno');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorDesayuno,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Desayuno',
        style: TextStyle(
          fontSize: 20,
          color: isHoraPasada
              ? Colors.grey
              : controller.textColorDesayuno,
        ),
      ),
    ));
  }

  Widget _buttomAlmuerzo() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        controller.onPressed('almuerzo');
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '¿Ya ha registrado su desayuno?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              actions: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                          ),
                          child: Text(
                            'Sí',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            controller.updateDesayunoRegistrado(false);
                            Get.forceAppUpdate();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.red),
                          ),
                          child: Text(
                            'No',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorAlmuerzo,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Almuerzo',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorAlmuerzo,
        ),
      ),
    ));
  }

  Widget _buttomCena() {
    return Obx(
          () => ElevatedButton(
        onPressed: () {
          controller.onPressed('cena');
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                    '¿Ya ha registrado su almuerzo?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87
                  ),
                ),
                actions: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200], // Color de fondo para los botones
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cerrar el diálogo
                              // Lógica cuando el usuario selecciona "Sí"
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.indigo), // Color de fondo para el botón "Sí"
                            ),
                            child: Text(
                              'Sí',
                              style: TextStyle(
                                color: Colors.white, // Color del texto para el botón "Sí"
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                            ),
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.buttonColorCena,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Text(
          'Cena',
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
        controller.onPressed('otro');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorOtro,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Otro',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorOtro,
        ),
      ),
      ),
    );
  }

  // Widget _buttomOlvido() {
  //   return Obx(
  //         () => ElevatedButton(
  //       onPressed: () {
  //         // controller.onPressed('otro');
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.white60,
  //         padding: EdgeInsets.symmetric(vertical: 10),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(5.0),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Expanded(
  //             child: Text(
  //               'Me olvide',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  Widget _buttonSaludable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saludable',
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
                  _buttomYes(),
                  _buttomNo(),
                ],
              ),
              SizedBox(height: 10),
              // _buttomOlvido()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttomYes() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        controller.pressed('si');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorSi,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 72),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'Si',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorSi,
        ),
      ),
    ),
    );
  }

  Widget _buttomNo() {
    return Obx(() => ElevatedButton(
      onPressed: () {
        controller.pressed('no');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.buttonColorNo,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 72),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        'No',
        style: TextStyle(
          fontSize: 20,
          color: controller.textColorNo,
        ),
      ),
    ),
    );
  }

  Widget _buttoms(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10),
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
        controller.createFeeding();
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
