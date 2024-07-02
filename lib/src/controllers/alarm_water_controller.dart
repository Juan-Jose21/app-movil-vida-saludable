import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmController extends GetxController {
  late SharedPreferences _prefs;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AlarmController() {
    _initPreferences();
    _initNotifications();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await loadAlarmState();
  }

  void _initNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      },
    );
  }

  RxMap<String, bool> alarmState = {
    "Después de despertar": false,
    "Antes del desayuno": false,
    "Después del desayuno": false,
    "Antes del almuerzo": false,
    "Después del almuerzo": false,
    "Antes de la cena": false,
    "Después de la cena": false,
    "Antes de ir a dormir": false,
  }.obs;

  Future<void> toggleAlarm(String title, String time) async {
    alarmState[title] = !alarmState[title]!;

    await saveAlarmState();

    if (alarmState[title]!) {
      DateTime now = DateTime.now();
      List<String> parts = time.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      DateTime scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);

      if (scheduledTime.isBefore(now)) {
        scheduledTime = scheduledTime.add(Duration(days: 1));
      }

      print('Programando notificación para $scheduledTime');
      await scheduleNotification(title, scheduledTime);
      await saveScheduledAlarm(title, scheduledTime);
    } else {
      await cancelNotification(title);
      await removeScheduledAlarm(title);
    }

    print('Estado de las alarmas:');
    alarmState.forEach((key, value) {
      print('$key: ${value ? 'Activada' : 'Desactivada'}');
    });

    update();
  }

  Future<void> saveAlarmState() async {
    await _prefs.clear();
    for (String key in alarmState.keys) {
      await _prefs.setBool(key, alarmState[key]!);
    }
  }

  Future<void> loadAlarmState() async {
    for (String key in alarmState.keys) {
      bool? isActive = _prefs.getBool(key);
      if (isActive != null) {
        alarmState[key] = isActive;
      }
    }
    await restoreScheduledAlarms();
  }

  Future<void> scheduleNotification(String title, DateTime scheduledTime) async {
    tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      title.hashCode,
      title,
      'Es hora de tomar agua',
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('Programando notificación:');
    print('ID: ${title.hashCode}');
    print('Título: $title');
    print('Cuerpo: Es hora de $title');
    print('Fecha y hora programadas: $tzScheduledTime');
  }

  Future<void> cancelNotification(String title) async {
    await flutterLocalNotificationsPlugin.cancel(title.hashCode);
  }

  Future<void> saveScheduledAlarm(String title, DateTime scheduledTime) async {
    String key = 'scheduled_$title';
    await _prefs.setString(key, scheduledTime.toIso8601String());
  }

  Future<void> removeScheduledAlarm(String title) async {
    String key = 'scheduled_$title';
    await _prefs.remove(key);
  }

  Future<void> restoreScheduledAlarms() async {
    for (String key in _prefs.getKeys()) {
      if (key.startsWith('scheduled_')) {
        String title = key.replaceFirst('scheduled_', '');
        String? scheduledTimeString = _prefs.getString(key);
        if (scheduledTimeString != null) {
          DateTime scheduledTime = DateTime.parse(scheduledTimeString);
          if (scheduledTime.isAfter(DateTime.now())) {
            await scheduleNotification(title, scheduledTime);
          }
        }
      }
    }
  }

  void printScheduledAlarms() {
    for (String key in _prefs.getKeys()) {
      if (key.startsWith('scheduled_')) {
        String title = key.replaceFirst('scheduled_', '');
        String? scheduledTimeString = _prefs.getString(key);
        if (scheduledTimeString != null) {
          DateTime scheduledTime = DateTime.parse(scheduledTimeString);
          print('Alarma: $title programada para $scheduledTime');
        }
      }
    }
  }
}
