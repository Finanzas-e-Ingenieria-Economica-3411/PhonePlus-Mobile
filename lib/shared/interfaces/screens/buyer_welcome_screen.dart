import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../credits/interfaces/providers/bond_provider.dart';
import '../../../credits/interfaces/screens/bonds_screen.dart';
import '../../../ui/constants/constant.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';

class BuyerWelcomeScreen extends StatefulWidget {
  const BuyerWelcomeScreen({super.key});

  @override
  State<BuyerWelcomeScreen> createState() => _BuyerWelcomeScreenState();

}

class _BuyerWelcomeScreenState extends State<BuyerWelcomeScreen> {

  @override
  void initState(){
    super.initState();
    // TODO: Cambiar a lógica real cuando el backend esté listo
    Future.microtask(() => Provider.of<BondProvider>(context, listen: false).getAvailableBonds());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: Colors.black
            )
        ),
        backgroundColor: background,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: primary,
            child: Icon(
              Icons.person,
              color: background,
            ),
          ),
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
          ],
        ),
      ),
    );
  }
}
