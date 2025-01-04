// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

List<UserRegister> userRegisterFromJson(String str) => List<UserRegister>.from(
    json.decode(str).map((x) => UserRegister.fromJson(x)));

String userRegisterToJson(List<UserRegister> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRegister {
  String username;
  String nameSurname;
  String phone;
  String email;
  String password;
  String profilePic;
  int type;

  UserRegister({
    required this.username,
    required this.nameSurname,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.type,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        username: json["username"],
        nameSurname: json["nameSurname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "nameSurname": nameSurname,
        "phone": phone,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "type": type,
      };
}
