import 'package:app_vida_saludable/src/controllers/register_sun_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';


class RegisterSunPage extends StatelessWidget {

  final RegisterSunController con = Get.put(RegisterSunController());

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
            _formSun(context)
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
        'Luz Solar',
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
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/img/imgSol.webp',
                    width: 60,
                    height: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 250),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          child: Text(
                            'Horario recomendable 07:00 - 09:00 y 16:00 mínimo 25 minutos',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
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

  Widget _formSun(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25, left: 25, right: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _inputDate(context),
            // SizedBox(height: 15),
            // _inputTime(context),
            // SizedBox(height: 15),
            // _inputTimeEnd(context),
            SizedBox(height: 25),
            _infoCronometro(context),
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
            await con.selectDate();
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
                  text: DateFormat('yyyy-MM-dd').format(con.currentDateTime),
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

  // Widget _inputTime(BuildContext context) {
  //   return Container(
  //     // margin: EdgeInsets.only(top: 10),
  //     width: double.infinity,
  //     child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             _inputTimeStart(context),
  //             _inputTimeEnd(context)
  //           ],
  //     ),
  //   );
  // }

  // Widget _inputTimeStart(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Hora Inicio',
  //         style: TextStyle(
  //           color: Colors.black54,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 1),
  //       GestureDetector(
  //         onTap: () async {
  //           await con.selectTime();
  //         },
  //         child: Container(
  //           height: 10,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Colors.black12,
  //           ),
  //           child: Obx(
  //                 () => TextField(
  //               enabled: false,
  //               controller: TextEditingController(
  //                 text: DateFormat('HH:mm:ss').format(con.currentDateTime),
  //               ),
  //               style: TextStyle(
  //                 color: Colors.black87,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //                 suffixIcon: Icon(Icons.access_time, color: Colors.black87),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _inputTimeEnd(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Hora Fin',
  //         style: TextStyle(
  //           color: Colors.black54,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 1),
  //       GestureDetector(
  //         onTap: () async {
  //           await con.selectTime();
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Colors.black12,
  //           ),
  //           child: Obx(
  //                 () => TextField(
  //               enabled: false,
  //               controller: TextEditingController(
  //                 text: DateFormat('HH:mm:ss').format(con.endDateTime),
  //               ),
  //               style: TextStyle(
  //                 color: Colors.black87,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //                 suffixIcon: Icon(Icons.access_time, color: Colors.black87),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
        SizedBox(height: 14),
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Obx(() => Text(
                con.formattedTime,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
              SizedBox(height: 10),
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
                onTap: con.startTimer,
                child: Icon(Icons.play_circle, color: Colors.indigo, size: 35),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: con.pauseTimer,
                child: Icon(Icons.pause_circle, color: Colors.red, size: 35),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: con.resetTimer,
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
      margin: EdgeInsets.only(top: 50),
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
        con.createSun();
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
