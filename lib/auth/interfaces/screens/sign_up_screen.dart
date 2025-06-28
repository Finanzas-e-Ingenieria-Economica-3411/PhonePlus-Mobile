import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/auth/interfaces/screens/login_screen.dart';

import '../../../shared/interfaces/widgets/custom_button.dart';
import '../../../ui/constants/constant.dart';
import '../widgets/auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController dniController;

  @override
  void initState(){
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    dniController = TextEditingController();
  }

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    dniController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 70),
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            spacing: 50,
            children: [
              SizedBox(
                width: 170,
                child: Text(
                  "Registrate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: text,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Form(
                  child: Column(
                    spacing: 50,
                    children: [
                      AuthTextField(
                        controller: firstNameController,
                        hintText: 'Ingrese su nombre',
                        label: 'Nombre',
                        onValidate: (String? value) {

                        },
                        isPassword: false,
                      ),
                      AuthTextField(
                        controller: lastNameController,
                        hintText: 'Ingrese su apellido',
                        label: 'Apellido',
                        onValidate: (String? value) {

                        },
                        isPassword: false,
                      ),
                      AuthTextField(
                        controller: dniController,
                        hintText: 'Ingrese su dni',
                        label: 'DNI',
                        onValidate: (String? value) {

                        },
                        isPassword: false,
                      ),
                    ],
                  )
              ),
              Container(
                width: double.infinity,
                height: 0.6,
                decoration: BoxDecoration(
                  color: font
                ),
              ),
              Form(
                  child: Column(
                    spacing: 50,
                    children: [
                      AuthTextField(
                        controller: emailController,
                        hintText: 'Ingrese su correo',
                        label: 'Usuario',
                        onValidate: (String? value) {

                        },
                        isPassword: false,
                      ),
                      AuthTextField(
                        controller: passwordController,
                        hintText: 'Ingrese su contraseña',
                        label: 'Contraseña',
                        onValidate: (String? value) {

                        },
                        isPassword: true,
                      ),
                      AuthTextField(
                        controller: repeatPasswordController,
                        hintText: 'Ingrese denuevo su contraseña',
                        label: 'Repita su contraseña',
                        onValidate: (String? value) {

                        },
                        isPassword: true,
                      ),
                      Column(
                        spacing: 20,
                        children: [
                          CustomButton(
                            label: "Registrate",
                            onPressed:(){

                            },
                            isStrong: true,
                          ),
                          CustomButton(
                            label: "Iniciar sesion",
                            onPressed:(){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                            },
                            isStrong: false,
                          )
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
