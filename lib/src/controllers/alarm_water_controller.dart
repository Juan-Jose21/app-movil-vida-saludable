import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Map<String, bool> alarmState = {
    "Después de despertar": false,
    "Antes del desayuno": false,
    "Después del desayuno": false,
    "Antes del almuerzo": false,
    "Después del almuerzo": false,
    "Antes de la cena": false,
    "Después de la cena": false,
    "Antes de ir a dormir": false,
  };

  Future<void> initializeNotifications() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> scheduleAlarm(int id, DateTime scheduledDate, String alarmTitle) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_channel_id',
      'alarm_channel_name',
      channelDescription: 'alarm_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    if (alarmState[alarmTitle] == true) {
      DateTime now = DateTime.now();


      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        alarmTitle,
        'Es hora de $alarmTitle', // Mensaje de la notificación
        tz.TZDateTime.from(scheduledDate, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }



  Future<void> scheduleAllAlarms() async {
    List<Map<String, String>> alarms = [
      {"title": "Después de despertar", "time": "08:30"},
      {"title": "Antes del desayuno", "time": "08:50"},
      {"title": "Después del desayuno", "time": "09:50"},
      {"title": "Antes del almuerzo", "time": "11:30"},
      {"title": "Después del almuerzo", "time": "13:30"},
      {"title": "Antes de la cena", "time": "18:30"},
      {"title": "Después de la cena", "time": "20:30"},
      {"title": "Antes de ir a dormir", "time": "22:34"},
    ];

    for (var i = 0; i < alarms.length; i++) {
      var alarm = alarms[i];
      var timeComponents = alarm['time']!.split(':');
      var scheduledDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(timeComponents[0]),
        int.parse(timeComponents[1]),
      );
      if (alarmState[alarm['title']!] == true) {
        await scheduleAlarm(i, scheduledDate, alarm['title']!);
      }
    }
  }

  Future<void> loadAlarmState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in alarmState.keys) {
      bool? isActive = prefs.getBool(key);
      if (isActive != null) {
        alarmState[key] = isActive;
      }
    }
  }

  Future<void> saveAlarmState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in alarmState.keys) {
      await prefs.setBool(key, alarmState[key]!);
    }
  }

  Card buildAlarmCard(BuildContext context, String title, String time) {
    bool isActive = alarmState[title] ?? false;

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
                onPressed: () async {
                  alarmState[title] = !isActive;
                  await saveAlarmState();
                  Get.forceAppUpdate();

                  if (isActive) {
                    await cancelAlarm(title);
                  } else {
                    var timeComponents = time.split(':');
                    var scheduledDate = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(timeComponents[0]),
                      int.parse(timeComponents[1]),
                    );
                    int id = title.hashCode;
                    await scheduleAlarm(id, scheduledDate, title);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cancelAlarm(String title) async {
    int id = title.hashCode;
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Future<void> initializeBackgroundAlarms() async {
  //   await AndroidAlarmManager.initialize();
  //   await AndroidAlarmManager.periodic(Duration(minutes: 1), 0, callback);
  // }
  // static void callback() {
  // }

}
