
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/screens/add_task.dart';
import 'package:task_manager/screens/profile_page.dart';
import 'package:task_manager/screens/setting_page.dart';
import '../model/tasks.dart';
import '../notification_services/local_notification_service.dart';
import '../notification_services/notification_details.dart';

import 'package:url_launcher/url_launcher.dart';

import '../services/database_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var notifyHelper = LocalNotificationService();
  final DatabaseServices _databaseServices = DatabaseServices.instance;
  bool done = false;
  @override
  void initState() {
    super.initState();
    //listenToNotificationStream();

  }
  void listenToNotificationStream() {
    LocalNotificationService.streamController.stream.listen(
          (notificationResponse) {
        //log(notificationResponse.id!.toString());
        //log(notificationResponse.payload!.toString());
        //logic to get product from database.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NotificationDetailsScreen(
              response: notificationResponse,
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, TaskProvider value, Widget? child) => DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
          appBar: appBar(),
          drawer: drawer(),
          floatingActionButton: floatingActionButton(value),
          body: TabBarView(
            children: [
              Center(
                child: FutureBuilder(
                  future: _databaseServices.getTasksByCategory("Personal"),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Task task = snapshot.data![index];
                        return getMyView(value, task);
                      },
                    );
                  },
                ),
              ),
              Center(
                child:FutureBuilder(
                  future: _databaseServices.getTasksByCategory("Work"),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Task task = snapshot.data![index];
                        return getMyView(value, task);
                      },
                    );
                  },
                ),
              ),
              Center(
                child: FutureBuilder(
                  future: _databaseServices.getTasksByCategory("Others"),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Task task = snapshot.data![index];
                        return getMyView(value, task);
                      },
                    );
                  },
                ),
              )
            ],
          )),
    ),


    );
  }

  FloatingActionButton floatingActionButton(value) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  AddTask()));
      },
      backgroundColor: Colors.tealAccent,
      tooltip: 'Add Task',
      child: const Icon(Icons.alarm_on),
    );
  }

  Drawer drawer() {
    return Drawer(
      elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).appBarTheme.backgroundColor),
            child: Text(
              'Task Reminder',
              style: TextStyle(fontSize: 35,color: Colors.black),
            ),
          ),
          ListTile(
            title: Text('Profile',style: TextStyle(color:Colors.grey.shade900)),
            leading: Icon(Icons.person,color:Colors.grey.shade900,),
            onTap: () {

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            title: Text('Theme',style: TextStyle(color:Colors.grey.shade900),),
            leading: Icon(Icons.dark_mode, color: Colors.grey.shade900,),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder:(context) => const SettingPage()));
              },
          ),

          ListTile(
            title: Text('Share',style: TextStyle(color: Colors.grey.shade900)),
            leading: Icon(Icons.share,color:Colors.grey.shade900,),
            onTap: () async{
              final Uri _url = Uri.parse('https://drive.google.com/file/d/1HQeEiw--yf6EiuHI0ZKTSD_jZCH3h1tS/view?usp=drivesdk');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
          ),
          ListTile(
            title: Text('Privacy Policy',style: TextStyle(color: Colors.grey.shade900)),
            leading: Icon(Icons.policy,color:Colors.grey.shade900,),
            onTap: () async{
              final Uri _url = Uri.parse('https://drive.google.com/file/d/1HQeEiw--yf6EiuHI0ZKTSD_jZCH3h1tS/view?usp=drivesdk');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
          ),
          ListTile(
            title: Text('Help',style: TextStyle(color: Colors.grey.shade900)),
            leading: Icon(Icons.help,color: Colors.grey.shade900,),
            onTap: () {},
          ),
          ListTile(
            title: Text('Version 1.0.0',style: TextStyle(color: Colors.black38),),
            leading: Icon(Icons.layers,color: Colors.black38,),
          ),
        ],
      ),
    );
  }
  GestureDetector getMyView(value,task,){
    return GestureDetector(
      onDoubleTap: () {
        // print(task.isCompleted);
        //  _databaseServices.deleteTask(task.id);
        value.update(task);
      },
      onLongPress:() {
        value.delete(task.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // color: Color((Random().nextDouble()*0xFFFFFF).toInt() <<0).withOpacity(1.0),
            color: task.category =="Personal"?Colors.deepPurple.shade900:task.category == "Others"?Colors.indigoAccent:Colors.teal

          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${task.title}",
                        style:const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),

                      ),
                      task.isCompleted==1?const Icon(Icons.task_alt,size: 20,):Container(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task.content,
                    style: TextStyle(fontSize: 15, color: Colors.grey[100]),

                  ),
                  const SizedBox(height: 12,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${task.date.split(" ")[0]}",
                        style:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),

                      ),

                      const SizedBox(width: 25),
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      Text(
                        " ${task.time} ",
                        style:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),

                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Text(
                        task.repeat=="None"?"No Repeat":task.repeat,
                        style:TextStyle(fontSize: 13, color: Colors.grey[100]) ,
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1 ? "COMPLETED" : "TASK",
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),

              ),
            ),
          ]),

        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      iconTheme: IconThemeData(color: Colors.black),
      title: const Text('Task Reminder'),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
      bottom: const TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black54,
        tabs: [
          Tab(
            icon: Icon(
              Icons.account_box,
              size: 28,
            ),
            text: "Personal",
          ),
          Tab(
            icon: Icon(
              Icons.work,
              size: 28,
            ),
            text: "Work",
          ),
          Tab(
            icon: Icon(
              Icons.task_alt,
              size: 28,
            ),
            text: "Others",
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
           LocalNotificationService.showBasicNotification();
         // notifiyerHelper.myShowSchduledNotification(16,DateTime.now().hour,DateTime.now().minute,"mo","jd");
          },
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) =>  SettingPage()));
          },
          icon: const Icon(Icons.settings),
        ),
      ],
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
