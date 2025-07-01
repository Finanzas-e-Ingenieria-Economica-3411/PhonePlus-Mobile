
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool isSuccess;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const CustomDialog({super.key, required this.title, required this.content, required this.isSuccess, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSuccess ? Image.network(
            "https://www.freeiconspng.com/img/23201",
            width: 100,
          )
              : Image.network(
            "https://tse1.mm.bing.net/th/id/OIP.r5UbQL03qo6xZYk91kDLvAHaHa?pid=Api&P=0&h=180",
            width: 100,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
            ),
          ),
          Text(
            content,
            style: TextStyle(
                fontSize: 15.0,
                color: isSuccess ? primary : Colors.red
            ),
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: onCancel,
           style: ElevatedButton.styleFrom(
              backgroundColor: background,
              foregroundColor: font,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
          child: Text(
            "Cancelar",
            style: TextStyle(
                fontSize: 25
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
          child: Text(
            "Confirmar",
            style: TextStyle(
                fontSize: 25
            ),
          ),
        )
      ],

    );
  }
}