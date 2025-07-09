import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Text(
          "Phone Plus",
          style: TextStyle(
            color: background,
            fontWeight: FontWeight.bold,
            fontSize: 50
          ),
        ),
      ),
    );
  }
}
