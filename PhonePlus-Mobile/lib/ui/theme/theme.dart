import 'package:flutter/material.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData.light().copyWith(
     scaffoldBackgroundColor: background,
    textTheme: TextTheme(
      displaySmall: TextStyle(
        color: font
      ),
      displayMedium: TextStyle(
        color: font
      ),
      displayLarge: TextStyle(
          color: font
      ),
    )
  );
}