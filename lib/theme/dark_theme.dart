import 'package:flutter/material.dart';

ThemeData dartTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme:AppBarTheme(
        backgroundColor: Colors.grey.shade700
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.grey,
      primary:Colors.white,
      // secondary: Colors.grey[500]!,
      // tertiary: Colors.grey[800]!,
      // not
    )
);