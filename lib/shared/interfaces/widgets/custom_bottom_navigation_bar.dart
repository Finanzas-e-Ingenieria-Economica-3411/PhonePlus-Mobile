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
        NewPlanScreen(),
      ConfigScreen(),
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
      BottomNavigationBarItem(
        icon: Icon(Icons.settings, size: 30),
        label: 'Configuración',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white, // Fondo claro para mejor contraste
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.black,
          textTheme: Theme.of(context).textTheme.copyWith(
            bodySmall: TextStyle(color: Colors.black),
          ),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.green[800],
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800]),
          unselectedLabelStyle: TextStyle(color: Colors.black54),
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
            Navigator.push(context, MaterialPageRoute(builder: (_) => screens[index]));
          },
          backgroundColor: Colors.white,
          items: sections,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
