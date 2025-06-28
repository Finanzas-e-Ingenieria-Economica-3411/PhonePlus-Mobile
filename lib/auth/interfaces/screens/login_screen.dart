import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/auth/interfaces/screens/sign_up_screen.dart';
import 'package:phoneplus/auth/interfaces/widgets/auth_text_field.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_button.dart';
import 'package:phoneplus/ui/constants/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 late TextEditingController emailController;
 late TextEditingController passwordController;

 @override
 void initState(){
   super.initState();
   emailController = TextEditingController();
   passwordController = TextEditingController();
 }

 @override
 void dispose(){
   super.dispose();
   emailController.dispose();
   passwordController.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 150),
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            spacing: 100,
            children: [
               SizedBox(
                 width: 170,
                 child: Text(
                      "Bienvenido a Phone Plus",
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
                      Column(
                        spacing: 20,
                        children: [
                          CustomButton(
                            label: "Ingresar",
                            onPressed:(){

                            },
                            isStrong: true,),
                          CustomButton(
                            label: "Registrarte",
                            onPressed:(){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
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
