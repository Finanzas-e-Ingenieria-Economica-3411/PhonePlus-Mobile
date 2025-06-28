import 'package:flutter/material.dart';
import 'package:phoneplus/shared/interfaces/it/locators/logger_locator.dart';
import 'package:phoneplus/shared/interfaces/screens/home_screen.dart';
import 'package:phoneplus/ui/theme/theme.dart';

void main() {
  setUpLoggerLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      home: const HomeScreen()
    );
  }
}
