import '../../shared/infraestructure/utils/serializable.dart';

class SignInRequest with Serializable {
  String? email;
  String? password;

  SignInRequest({this.email, this.password});


  @override
  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}