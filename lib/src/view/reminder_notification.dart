import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderNotification {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings initializationSettingsAndroid;
  IOSInitializationSettings initializationSettingsIOS;
  InitializationSettings initializationSettings;

  ReminderNotification._constructor() {

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    initializationSettingsAndroid = AndroidInitializationSettings('icon');
    initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (_, __, ___, ____) {});
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (_) {});
  }

  static final ReminderNotification _instance = ReminderNotification._constructor();

  factory ReminderNotification() {
    return _instance;
  }

  scheduleNotification(TimeOfDay time, String title, String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('gbm_daily', 'Tägliche Erinnerungen', 'Tägliche Erinnerungsnotifications');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime ntime = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title, message,
        ntime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
    );

  }

  unscheduleNotification() {
    flutterLocalNotificationsPlugin.cancel(0);
  }
}