import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isStrong;
  const CustomButton({super.key, required this.label, required this.onPressed, required this.isStrong});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextButton(
         style: ButtonStyle(
           backgroundColor: isStrong ? WidgetStatePropertyAll<Color>(primary) : WidgetStatePropertyAll<Color>(background),
           foregroundColor: isStrong ? WidgetStatePropertyAll<Color>(background) : WidgetStatePropertyAll<Color>(font)
         ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
      ),
    );
  }
}
