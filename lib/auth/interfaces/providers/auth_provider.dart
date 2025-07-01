import 'package:flutter/cupertino.dart';
import 'package:phoneplus/auth/domain/sign_in_request.dto.dart';
import 'package:phoneplus/auth/domain/sign_up_request.dto.dart';
import 'package:phoneplus/auth/infraestructure/service/auth.service.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';

class AuthProvider extends ChangeNotifier{
  Future<void> signIn(String email, String password) async{
      try{
        final AuthService authService = AuthService(resourcePath: "auth/sign-in");
        final request = SignInRequest(email: email, password:  password);
        final response = await authService.signIn(request);
        StorageHelper.saveUserId(response.id!);
        StorageHelper.saveToken(response.token!);
      } catch (e){
        throw Exception(e);
      }
  }

  Future<void> signUp(String email, String password, String name, String username,String dni, int roleId) async{
    try{
      final AuthService authService = AuthService(resourcePath: "auth/sign-up");
      final request = SignUpRequest(
          email: email,
          password:  password,
          name: name,
          userName: username,
          dni:dni,
          roleId: roleId
      );
      await authService.signUp(request);
    } catch (e){
      throw Exception(e);
    }
  }

  Future<void> requestEmailVerification(String email) async {
    try{
      final AuthService authService = AuthService(resourcePath: "auth/request-email-verification");
      await authService.requestEmailVerification(email);
    } catch (e){
      throw Exception(e);
    }
  }


  String? validateEmail(String email){
    if (!email.contains("@")){
      return "El correo no es válido";
    }
    if (email.isEmpty){
      return "El email es requerido";
    }
    return null;
  }
}