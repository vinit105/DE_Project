
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/notification_services/local_notification_service.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/screens/homepage.dart';
import '../services/database_services.dart';
import '../ui/input_fields.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var notifyHelper = LocalNotificationService();
  final DatabaseServices _databaseServices = DatabaseServices.instance;

  TimeOfDay? pickedTime = TimeOfDay.now();
  DateTime variable =DateTime.now().add(const Duration(minutes: 2));
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 2)));

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  List<String> category = [
    "Personal",
    "Work",
    "Others",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder:
          (BuildContext context, TaskProvider taskProvider, Widget? child) =>
              Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.teal,
        //   onPressed: () {
        //     _validateDate();
        //     Navigator.of(context).pop();
        //   },
        //   child: const Icon(Icons.add, color: Colors.white,),
        // ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Add Reminder",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          //color: Colors.yellow,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Task",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                MyInputField(
                  title: "Title*",
                  hint: "Enter title here",
                  controller: _titleController,
                  isMax: true,
                ),
                MyInputField(
                  title: "Content*"
                      "",
                  hint: "Enter Content here",
                  controller: _noteController,
                ),
                MyInputField(
                  title: "Date",
                  hint: DateFormat.yMEd().format(selectedDate),
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      _getDateFromUser(taskProvider);
                      setState(() {});
                    },
                  ),
                ),
                MyInputField(
                  title: "Time",
                  hint: startTime,
                  widget: IconButton(
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      _getTimeFromUser(true, taskProvider);
                    },
                  ),
                ),
                MyInputField(
                  title: "Repeat",
                  hint: taskProvider.selectRepeat,
                  widget: Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.grey.shade600,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          // color: Get.isDarkMode ? Colors.white : Colors.black
                          color: Colors.black),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        taskProvider.select(newValue!);
                      },
                      items: repeatList.map<DropdownMenuItem<String>>(
                        (String? value) {
                          return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()));
                        },
                      ).toList(),
                    ),
                  ),
                ),
                MyInputField(
                  title: "Category",
                  hint: taskProvider.selectCategory,
                  widget: Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.grey.shade600,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          // color: Get.isDarkMode ? Colors.white : Colors.black
                          color: Colors.black),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        taskProvider.setCategory(newValue!);
                      },
                      items: category.map<DropdownMenuItem<String>>(
                        (String? value) {
                          return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()));
                        },
                      ).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        elevation: 5,
                        tooltip: 'Add',
                        onPressed: () {
                          _validateDate(taskProvider);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateDate(TaskProvider value) {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty ) {
      // add tp database
      //  _addTaskToDb();

      _databaseServices.addTask(
          _titleController.text,
          _noteController.text,
          selectedDate.toString(),
          startTime,
          value.selectRepeat,
          value.selectCategory);

      notifyHelper.notificationScheduled(scheduledNotificationDateTime: variable,title: _titleController.text,body: _noteController.text, isAction: true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }

  }

  _getDateFromUser(value) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      selectedDate = pickedDate;
      variable = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,pickedTime!.hour,pickedTime!.minute);
      setState(() {});
    }
  }

  _getTimeFromUser(bool isStartTime, value) async {
    pickedTime = await showTimePicker(context: context,initialTime: TimeOfDay.now());
  if(pickedTime != null)  {
    variable = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,pickedTime!.hour,pickedTime!.minute);
    startTime = variable.toString().split(" ")[1].split(".")[0];
    setState(() {});
  }

  }
}
