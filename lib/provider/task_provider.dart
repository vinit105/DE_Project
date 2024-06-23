
import 'package:flutter/cupertino.dart';
import 'package:task_manager/services/database_services.dart';

import '../model/tasks.dart';

class TaskProvider extends ChangeNotifier {
  String title = "";
  String content = "";
  String date = "";
  String time = "";
  String repeat = "";
  String category = "";
  int isCompleted = 0;

  String selectRepeat = "None";
  String selectCategory = "Personal";
  bool setDarkMode = false;


  final DatabaseServices _databaseServices = DatabaseServices.instance;


  delete(String id) {
    _databaseServices.deleteTask(id);
    notifyListeners();
  }
  gett(){
    notifyListeners();
  }

  update(task) {
    _databaseServices.updateComplete(task.id, task.isCompleted == 0 ? 1 : 0);
    notifyListeners();
  }

  select(String newValue) {
    selectRepeat = newValue;
    notifyListeners();
  }

  setCategory(String newValue) {
    selectCategory = newValue;
    notifyListeners();
  }

  reset() {
    selectCategory = "Personal";
    selectRepeat = "None";
  }

   changeTheme(){
    setDarkMode = !setDarkMode;
    notifyListeners();
  }

}
