import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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
        icon: 'mipmap/launcher_icon',
        largeIcon: const DrawableResourceAndroidBitmap('mipmap/launcher_icon'),
        sound:
            RawResourceAndroidNotificationSound('sound.wav'.split('.').first));
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      10,
      'Basic Notification',
      'Task Reminder',
      details,
      payload: "Payload Data",
    );
  }

  initializeNotification() async {
    //tz.initializeTimeZones();
    // this is for latest iOS settings
    _configureLocalTimezone();
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> notificationScheduled(
      {int id = 0,
      String? title,
      String? body,
      required bool isAction,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(isAction),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  notificationDetails(bool isAction) {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          getRandomString(8),
          'taskReminder',
          playSound: true,
          priority: Priority.high,
          icon: 'mipmap/launcher_icon',
          actions: isAction
              ? <AndroidNotificationAction>[
                  const AndroidNotificationAction(
                    "id",
                    "Mark as Complete",
                    showsUserInterface: true,
                  ),
                ]
              : null,
          importance: Importance.max,
          sound:
              RawResourceAndroidNotificationSound('sound.wav'.split('.').first),
        ),
        iOS: const DarwinNotificationDetails());
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/launch');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  cancel() {
    notificationsPlugin.cancelAll();
    flutterLocalNotificationsPlugin.cancelAll();
  }


  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
