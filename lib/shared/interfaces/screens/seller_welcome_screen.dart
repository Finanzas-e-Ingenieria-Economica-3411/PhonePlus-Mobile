import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/constants/constant.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_button.dart';

class SellerWelcomeScreen extends StatelessWidget {
  const SellerWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: Colors.black
            )
        ),
        backgroundColor: background,
        centerTitle: true,
        leading: Icon(
          Icons.person,
          color: primary,
          size: 40,
        ),
        title:  Text(
          "Inicio",
          style: TextStyle(
              color: font,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          spacing: 25,
          children: [
            Image.asset("assets/d6d7fb08-90b3-49a0-9b4a-c6cbd10b5245.jpeg"),
            CustomButton(label: "Ver", onPressed: (){}, isStrong: true)
          ],
        ),
      ),
    );
  }
}
