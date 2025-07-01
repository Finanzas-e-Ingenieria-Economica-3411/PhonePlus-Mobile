import 'package:logger/logger.dart';
import 'package:phoneplus/auth/domain/sign_in_request.dto.dart';
import 'package:phoneplus/auth/domain/sign_up_request.dto.dart';
import 'package:phoneplus/auth/domain/user_authenticated_response.dto.dart';
import 'package:phoneplus/shared/infraestructure/service/base_service.dart';

import '../../../core/constants/constant.dart';


class AuthService extends BaseService {
  AuthService({required super.resourcePath});

  Future<bool> signUp(SignUpRequest request) async{
     try{
       await post(request);
       return true;
     } catch (e){
       logger.log(Level.error, "An error has ocurred during sign up process");
       throw  Exception(e);
    }
  }

  Future<UserAuthenticatedResponseDto> signIn(SignInRequest request) async {
    try{
      final response = await post(request);
      final userAuthenticated = UserAuthenticatedResponseDto.fromJson(response);
      return userAuthenticated;

    } catch (e){
      logger.log(Level.error, "An error has ocurred during sign up process");
      throw  Exception(e);
    }
  }

  Future<void> requestEmailVerification(String email) async{
    try{
      await dio.post("${Constant.baseUrl}$resourcePath/$email");
    } catch (e){
      logger.log(Level.error, "An error has ocurred during request email verification process $e");
      throw  Exception(e);
    }
  }

}