import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? onValidate;
  final bool isPassword;
  const AuthTextField({super.key, required this.controller, required this.hintText, required this.label, required this.onValidate, required this.isPassword});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isPasswordVisible = false;
  @override
  void initState(){
    super.initState();
    isPasswordVisible = widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.onValidate,
      controller: widget.controller,
      obscureText: isPasswordVisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          fontSize: 18.0,
        color: text
      ),
      cursorColor: text,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
            fontSize: 18.0,
            color: text
        ),
        filled: true,
        fillColor: background,
        errorStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: font,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: font,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: font,
          ),
        ),
        suffixIcon: widget.isPassword ? IconButton(
            onPressed: (){
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            icon: Icon(
                Icons.visibility,
              size: 30,
            )
        ) : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 18.0),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
      ),
    );
  }
}
