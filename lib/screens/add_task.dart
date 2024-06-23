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
  var notifiyerHelper = LocalNotificationService();
  final DatabaseServices _databaseServices = DatabaseServices.instance;

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 1)));

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
      builder: (BuildContext context, TaskProvider taskProvider, Widget? child) =>
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

          iconTheme: IconThemeData(color: Colors.black),
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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
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
                    icon:  Icon(
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
                    icon:  Icon(
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
                      icon:  Icon(
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
                      icon:  Icon(
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
                        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
//     DateTime startDate = DateFormat("hh:mma").parse(_startTime);
//
//     String _lastTime = DateFormat("hh:mma").format(DateTime.now());
//     DateTime endDate =DateFormat("hh:mma").parse(_lastTime);
//
//     Duration dif = endDate.difference(startDate);
//
// // Print the result in any format you want
//     print(dif.toString()); // 12:00:00.000000
//     print(dif.inHours); // 12

    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // add tp database
      //  _addTaskToDb();

      _databaseServices.addTask(_titleController.text,
          _titleController.text,
          _noteController.text,
          selectedDate.toString(),
          startTime,
          value.selectRepeat,
          value.selectCategory);

      notifiyerHelper.myShowSchduledNotification(
          selectedDate.day,
          int.parse(startTime.split(":")[0]),
          int.parse(startTime.split(":")[1].split(" ")[0]),
          _titleController.text,
          _noteController.text);
     Navigator.of(context).pop();
      value.reset();
      _titleController.clear();
      _noteController.clear();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => const HomePage()));
    }
    //
    // if(dif.inSeconds >0){
    //   _startTime =DateFormat("hh:mma").format(DateTime.now());
    // }

// Get the Duration using the diferrence method
  }

  _getDateFromUser(value) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      selectedDate = pickedDate!;
      setState(() {});
    }
  }

  _getTimeFromUser(bool isStartTime, value) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      //print("time cancel");
    } else if (pickedTime != null) {
      startTime = pickedTime.format(context);
      setState(() {});
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        //     initialTime: TimeOfDay(
        //         hour: int.parse(_startTime.split(":")[0]),
        //         minute: int.parse(_startTime
        //             .split(":")[2]
        //             .split(" ")[0])) // _startTime --> 10:30 AM is integer
        // );
        initialTime: TimeOfDay.now());
  }
}
