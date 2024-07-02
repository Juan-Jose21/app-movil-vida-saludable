import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/alarm_water_controller.dart';

class AlarmWaterPage extends StatefulWidget {
  @override
  _AlarmWaterPageState createState() => _AlarmWaterPageState();
}

class _AlarmWaterPageState extends State<AlarmWaterPage> {
  final AlarmController _alarmController = Get.put(AlarmController());

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
            _alarms(context),
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
        ),
      ),
    );
  }

  Widget _textTitle() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Text(
        'Alarmas',
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

  Widget _alarms(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildAlarmCard(context, "Después de despertar", "08:30"),
            _buildAlarmCard(context, "Antes del desayuno", "08:50"),
            _buildAlarmCard(context, "Después del desayuno", "09:50"),
            _buildAlarmCard(context, "Antes del almuerzo", "11:30"),
            _buildAlarmCard(context, "Después del almuerzo", "13:30"),
            _buildAlarmCard(context, "Antes de la cena", "18:30"),
            _buildAlarmCard(context, "Después de la cena", "20:30"),
            _buildAlarmCard(context, "Antes de ir a dormir", "21:30"),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmCard(BuildContext context, String title, String time) {
    bool isActive = _alarmController.alarmState[title] ?? false;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.02,
        left: 25,
        right: 25,
      ),
      elevation: 1,
      color: Colors.indigo[100],
      child: SizedBox(
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 10, 0),
              child: IconButton(
                icon: Icon(
                  isActive ? Icons.toggle_on : Icons.toggle_off,
                  color: isActive ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  _alarmController.toggleAlarm(title, time);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
