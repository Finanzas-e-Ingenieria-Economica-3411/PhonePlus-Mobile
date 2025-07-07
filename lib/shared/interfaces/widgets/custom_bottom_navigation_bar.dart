import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/constants/constant.dart';
import '../screens/config_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>
                  ConfigScreen()
                ),
              );
            }
          },
          backgroundColor: primary,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home,
                    size: 30,
                  ),
                label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.list_alt,
                    size: 30,
                  ),
                label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.add,
                    size: 30,
                  ),
                label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings,
                    size: 30,
                  ),
                label: ''
              ),
            ]
        ),
    );
  }
}
