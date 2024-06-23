import 'package:flutter/material.dart';
import 'package:task_manager/theme/light_theme.dart';
import 'package:task_manager/theme/dark_theme.dart';
class ThemeProvider with ChangeNotifier {
  static ThemeData _themeData = lightTheme;
  static ThemeData getTheme(){
    return _themeData;
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if(_themeData == lightTheme){
      _themeData = dartTheme;
      notifyListeners();
    }
    else {
      _themeData = lightTheme;
      notifyListeners();
    }
  }


}