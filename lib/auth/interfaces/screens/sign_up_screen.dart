import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneplus/auth/interfaces/providers/auth_provider.dart';
import 'package:phoneplus/auth/interfaces/screens/login_screen.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController userController;
  bool isSeller = false;

  @override
  void initState(){
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    dniController = TextEditingController();
    userController = TextEditingController();
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
    userController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
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
                        label: 'Email',
                        onValidate: (String? value) {

                        },
                        isPassword: false,
                      ),
                      AuthTextField(
                        controller: userController,
                        hintText: 'Ingrese su usuario',
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
                      Row(
                        children: [
                          Text(
                              "Soy emisor",
                            style: TextStyle(
                              color: text,
                              fontSize: 17
                            ),
                          ),
                          Checkbox(
                              value: isSeller,
                              onChanged: (_){
                                setState(() {
                                  isSeller = !isSeller;
                                });
                              }
                          ),
                        ],
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
                            onPressed:() async{
                              try{
                                authProvider.signUp(
                                    emailController.text,
                                    passwordController.text,
                                    "${firstNameController.text} ${lastNameController.text}",
                                    userController.text,
                                    dniController.text,
                                    isSeller ? 3 : 2
                                );
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return CustomDialog(
                                          title: "Registro Exitoso!",
                                          content: "Se ha registrado exitosamente su usuario, por favor revise su bandeja para confirmar su correo",
                                          isSuccess: true,
                                          onConfirm: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                          },
                                          onCancel: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                          },
                                      );
                                    }
                                );
                              } catch (_){
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return CustomDialog(
                                        title: "Ocurrió un error!",
                                        content: "Ocurrió un error al registrar su usuario, por favor revise sus datos e intentelo más tarde",
                                        isSuccess: false,
                                        onConfirm: (){
                                          Navigator.pop(context);
                                        },
                                        onCancel: (){
                                          Navigator.pop(context);
                                        },
                                      );
                                    }
                                );
                              }
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
