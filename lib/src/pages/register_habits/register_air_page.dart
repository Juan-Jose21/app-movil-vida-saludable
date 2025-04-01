import 'package:app_vida_saludable/src/controllers/register_air_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class RegisterAirPage extends StatelessWidget {

  final RegisterAirController con = Get.put(RegisterAirController());

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
        'Aire Puro',
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
                    'assets/img/aire_puro.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 220),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          child: Text(
                            'Horario recomendable 07:00 a 09:00 y 16:00 mínimo 25 minutos',
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

  Widget _formSun(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.25,
        left: 25,
        right: 25,
      ),
      // Ajustar la altura del contenedor para evitar desbordamiento
      height: MediaQuery.of(context).size.height * 0.99, // Ajusta este valor según sea necesario
      child: SingleChildScrollView(
        child: Column(
          children: [
            _inputDate(context),
            SizedBox(height: 15),
            _infoCronometro(context),
            SizedBox(height: 45),
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
        SizedBox(height: 5),
        Row(
          children: [
            // Checkbox para "Sol"
            Obx(
                  () => Row(
                children: [
                  Checkbox(
                    value: con.sol.value,
                    onChanged: (newValue) {
                      con.sol.value = newValue ?? false;
                    },
                  ),
                  Text(
                    'Luz Solar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 45),
            Obx(
                  () => Row(
                children: [
                  Checkbox(
                    value: con.ejercicio.value,
                    onChanged: (newValue) {
                      con.ejercicio.value = newValue ?? false;
                      if (!con.ejercicio.value) {
                        con.tipoEjercicioSeleccionado.value = '';
                      }
                    },
                  ),
                  Text(
                    'Ejercicio',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Obx(
              () => con.ejercicio.value
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                'Tipo de Ejercicio',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: DropdownButton<String>(
                  value: con.tipoEjercicioSeleccionado.value.isEmpty
                      ? null
                      : con.tipoEjercicioSeleccionado.value,
                  onChanged: (newValue) {
                    con.tipoEjercicioSeleccionado.value = newValue ?? '';
                  },
                  items: con.tiposEjercicio.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text('Selecciona un tipo de ejercicio'),
                  isExpanded: true,
                  underline: SizedBox(), // Elimina la línea inferior
                ),
              ),
            ],
          )
              : SizedBox(), // Si no está seleccionado, no mostrar nada
        ),
      ],
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
          ],
        ),
        SizedBox(height: 10),
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
      margin: EdgeInsets.only(top: 20),
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
        con.submitData();
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
