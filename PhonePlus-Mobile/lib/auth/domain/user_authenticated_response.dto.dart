class UserAuthenticatedResponseDto {
  int? id;
  String? email;
  String? token;
  String? name;
  String? userName;
  String? dni;
  String? role;

  UserAuthenticatedResponseDto(
      {this.id,
        this.email,
        this.token,
        this.name,
        this.userName,
        this.dni,
        this.role});

  UserAuthenticatedResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    token = json['token'];
    name = json['name'];
    userName = json['userName'];
    dni = json['dni'];
    role = json['role'];
  }

}