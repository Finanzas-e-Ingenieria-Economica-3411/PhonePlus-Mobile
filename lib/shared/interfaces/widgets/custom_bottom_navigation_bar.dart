import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/credits/interfaces/screens/bonds_screen.dart';
import 'package:phoneplus/credits/interfaces/screens/new_plan_screen.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/shared/interfaces/screens/buyer_welcome_screen.dart';
import 'package:phoneplus/shared/interfaces/screens/seller_welcome_screen.dart';

import '../../../ui/constants/constant.dart';
import '../screens/config_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  String role = "";

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    () async {
      final currentRole = await StorageHelper.getRole();
      setState(() {
        role = currentRole!;
      });
    }();
}

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ( role == "Emisor" ?
      SellerWelcomeScreen() : BuyerWelcomeScreen()),
      BondsScreen(),
      if (role == "Emisor")
        NewPlanScreen()
    ];

    List<BottomNavigationBarItem> sections = [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          label: 'Inicio'
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt,
            size: 30,
          ),
          label: role == "Emisor" ? "Mis bonos" : "Ver bonos"
      ),
      if (role == "Emisor")
        BottomNavigationBarItem(
          icon: Icon(Icons.add, size: 30),
          label: 'Nuevo Bono',
        ),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: BottomNavigationBar(
          selectedItemColor: background,
          unselectedItemColor: background,
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
            Navigator.push(context, MaterialPageRoute(builder: (_) => screens[index]));
          },
          backgroundColor: primary,
            items: sections
        ),
    );
  }
}
