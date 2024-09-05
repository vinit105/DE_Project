import 'package:flutter/material.dart';
import 'package:task_manager/notification_services/local_notification_service.dart';
import '../provider/task_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TaskProvider taskProvider = TaskProvider();
  var notifyHelper = LocalNotificationService();
  TimeOfDay obj = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        title: const Text(
          "Notification Setting",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      // body: Center(
      //   child: IconButton(
      //     icon: Icon(Icons.alarm_on),
      //     iconSize: 85,
      //     color: Colors.yellow,
      //     onPressed: () async{
      //       obj = (await showTimePicker(context: context, initialTime: TimeOfDay.now()))!;
      //       final now = DateTime.now();
      //       print(DateTime(now.year,now.month,now.day,obj.hour,obj.minute));
      //       print(",,,,,,");
      //       notifyHelper.my(scheduledNotificationDateTime: DateTime(now.year,now.month,now.day,obj.hour,obj.minute,30),title: "${obj.minute}",body: obj.toString());
      //       // notifyHelper.my(scheduledNotificationDateTime: DateTime.now().add(Duration(seconds: 1)),title: "${now.minute}");
      //     },
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Basic Notifications",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: const Text(
                  "Sample",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                 LocalNotificationService.showBasicNotification();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_off,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Cancel All Notifications",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                 showDialog(context:
                     context

                     , builder: (_) =>  AlertDialog(
                       title: const Text("Are you sure?",style: TextStyle(color: Colors.black),),
                       actions: [
                         TextButton(onPressed: () {
                           Navigator.of(context).pop();
                         }, child:const Text("No")),
                         TextButton(onPressed: () {
                           notifyHelper.cancel();
                           Navigator.of(context).pop();
                         }, child: const Text("Yes")),
                       ],
                     ));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.task_alt,
                  size: 30,
                  color: Colors.black,
                ),
                title: const Text(
                  "Cancel All Reminders",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  showDialog(context:
                  context

                      , builder: (_) =>  AlertDialog(
                        title: const Text("Are you sure?",style: TextStyle(color: Colors.black),),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                          }, child:const Text("No")),
                          TextButton(onPressed: () {
                            notifyHelper.cancel();
                            Navigator.of(context).pop();
                          }, child: const Text("Yes")),
                        ],
                      ));
                }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
