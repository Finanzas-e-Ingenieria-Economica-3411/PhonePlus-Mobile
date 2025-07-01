import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/auth/interfaces/screens/login_screen.dart';
import 'package:phoneplus/shared/interfaces/screens/welcome_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          WelcomePage(),
          LoginScreen(),
        ],
      ),
    );
  }
}
