import 'package:phoneplus/shared/infraestructure/utils/serializable.dart';

class SignUpRequest with Serializable {
  String? email;
  String? password;
  String? name;
  String? userName;
  String? dni;
  int? roleId;

  SignUpRequest(
      {this.email,
        this.password,
        this.name,
        this.userName,
        this.dni,
        this.roleId});



  @override
  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['userName'] = userName;
    data['dni'] = dni;
    data['roleId'] = roleId;
    return data;
  }
}