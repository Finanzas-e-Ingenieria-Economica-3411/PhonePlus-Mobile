import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/constants/constant.dart';

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
              )
            ]
        ),
    );
  }
}
