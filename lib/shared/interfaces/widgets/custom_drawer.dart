import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/constants/constant.dart';
import '../screens/config_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary
      ),
      child: Column(
        children: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>
                      ConfigScreen()
                  ),
                );
              },
              icon: Icon(
                  Icons.construction_outlined,
                color: background,
              )
          )
        ],
      ),
    );
  }
}
