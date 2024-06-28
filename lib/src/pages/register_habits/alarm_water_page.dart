import 'package:flutter/material.dart';
import '../../controllers/alarm_water_controller.dart';

class AlarmWaterPage extends StatefulWidget {
  @override
  _AlarmWaterPageState createState() => _AlarmWaterPageState();
}

class _AlarmWaterPageState extends State<AlarmWaterPage> {
  final AlarmController _alarmController = AlarmController();

  @override
  void initState() {
    super.initState();
    _initializeNotificationsAndLoadAlarms();
  }

  Future<void> _initializeNotificationsAndLoadAlarms() async {
    await _alarmController.initializeNotifications();
    await _alarmController.loadAlarmState();
    setState(() {});
  }

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
        'Alarma',
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
            _alarmOne(context),
            _alarmTwo(context),
            _alarmThree(context),
            _alarmFour(context),
            _alarmFive(context),
            _alarmSix(context),
            _alarmSeven(context),
            _alarmEight(context),
          ],
        ),
      ),
    );
  }

  Card _alarmOne(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Después de despertar", "08:30");
  }

  Card _alarmTwo(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Antes del desayuno", "08:50");
  }

  Card _alarmThree(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Después del desayuno", "09:50");
  }

  Card _alarmFour(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Antes del almuerzo", "11:30");
  }

  Card _alarmFive(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Después del almuerzo", "13:30");
  }

  Card _alarmSix(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Antes de la cena", "18:30");
  }

  Card _alarmSeven(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Después de la cena", "20:30");
  }

  Card _alarmEight(BuildContext context) {
    return _alarmController.buildAlarmCard(context, "Antes de ir a dormir", "22:34");
  }
}
