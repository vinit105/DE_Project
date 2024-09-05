import 'package:flutter/material.dart';

import '../notification_services/local_notification_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  var notifyHelper = LocalNotificationService();

  SnackBar setReminder(String data){
    return SnackBar(backgroundColor:Colors.black,
      content: Text(" $data Set ", style: const TextStyle(color: Colors.white),),
      duration: const Duration(seconds: 1),);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Reminders",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 1 minute.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(minutes: 1)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().minute + 1}",
                      body: "1 minute Reminder", isAction: false);
                  ScaffoldMessenger.of(context).showSnackBar(setReminder("1 minute Reminder"));

                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 3 minutes.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(minutes: 3)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().minute + 3}",
                      body: "3 minutes Reminder", isAction: false);

                  ScaffoldMessenger.of(context).showSnackBar(setReminder("3 minutes Reminder"));
                },
              ),
              ListTile(
                  leading: const Icon(
                    Icons.task_alt_sharp,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Reminds after 5 minutes.",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    notifyHelper.notificationScheduled(
                        scheduledNotificationDateTime:
                            DateTime.now().add(const Duration(minutes: 5)),
                        title:
                            "It's ${DateTime.now().hour}:${DateTime.now().minute + 5}",
                        body: "5 minutes Reminder",isAction: false);

                    ScaffoldMessenger.of(context).showSnackBar(setReminder("5 minutes Reminder"));
                  }),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 30 minutes.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(minutes: 30)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().minute + 30}",
                      body: "30 minutes Reminder",isAction: false);

                  ScaffoldMessenger.of(context).showSnackBar(setReminder("30 minutes Reminder"));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 1 hour.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(hours: 1)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().hour + 1}",
                      body: "1 hour Reminder",isAction: false);

                  ScaffoldMessenger.of(context).showSnackBar(setReminder("1 hour Reminder"));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 6 hours.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(minutes: 6)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().hour + 6}",
                      body: "6 hours Reminder",isAction: false);

                  ScaffoldMessenger.of(context).showSnackBar(setReminder("6 hours Reminder"));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 12 hours.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(hours: 12)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().hour + 1}",
                      body: "12 hours Reminder",isAction: false);

                  ScaffoldMessenger.of(context).showSnackBar(setReminder("12 hours Reminder"));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Reminds after 1 day.",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  notifyHelper.notificationScheduled(
                      scheduledNotificationDateTime:
                          DateTime.now().add(const Duration(days: 1)),
                      title:
                          "It's ${DateTime.now().hour}:${DateTime.now().day + 1}",
                      body: "1 day Reminder",isAction: false);

                  ScaffoldMessenger.of(context).showSnackBar(setReminder("1 day Reminder"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
