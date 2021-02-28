import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// Singleton for a reminder notification occuring daily at a specified time.
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

  /// Schedule a notification at the specified [time] of day with a [title] and a [message]
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

  /// Unschedule the notification, so that it is no longer shown to the user.
  unscheduleNotification() {
    flutterLocalNotificationsPlugin.cancel(0);
  }
}