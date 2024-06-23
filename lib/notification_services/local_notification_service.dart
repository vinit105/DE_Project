import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
  StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@drawable/launch'),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //basic Notification
  static void showBasicNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
        'default', 'default',
        importance: Importance.max,
        priority: Priority.high,
        sound:
        RawResourceAndroidNotificationSound('sound.wav'
            .split('.')
            .first));
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      10,
      'Sample Notification',
      'Basic',
      details,
      payload: "Payload Data",
    );
  }

  initializeNotification() async {
    //tz.initializeTimeZones();
    // this is for latest iOS settings
    _configurLocalTimezone();

  }

//1.setup. [Done]
//2.Basic Notification. [Done]
//3.Repeated Notification. [Done]
//4.Scheduled Notification. [Done]
//5.Custom Sound. [Done]
//6.on Tab. [Done]
//7.Daily Notifications at specific time. [Done]
//8.Real Example in To Do App.

  tz.TZDateTime _convertTime(int day, int hour, int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleTime = tz.TZDateTime(tz.local,now.year, now.month, now.day,hour, minutes,);
    if(scheduleTime.isBefore(now)){
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }
    return scheduleTime;
  }

  Future<void> _configurLocalTimezone() async{
    tz.initializeTimeZones();
    final String timeXone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeXone));

  }

   void myShowSchduledNotification(int day,int hours, int minutes, String title, String content) async {
    print("days ${day}hours ${hours} minutes ${minutes}");
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'default',
      'id 3',
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.teal,
        sound:
        RawResourceAndroidNotificationSound('sound.wav'
            .split('.')
            .first)
    );
    // );
    NotificationDetails details =  NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      20,
     title,
      content,
     _convertTime(day,hours,minutes+1),
      details,
      payload: content,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );
  }

}