import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/credits/interfaces/screens/new_plan_screen.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_bottom_navigation_bar.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_button.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class BuyerWelcomeScreen extends StatelessWidget {
  const BuyerWelcomeScreen({super.key});

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
             Image.asset("assets/2de20633-6811-4178-b090-5c568b4dbc2d.jpeg"),
             CustomButton(
                 label: "Nuevo",
                 onPressed: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NewPlanScreen()));
                 },
                 isStrong: true
             ),
            CustomButton(label: "Ver", onPressed: (){}, isStrong: true)
          ],
        ),
      ),
    );
  }
}
