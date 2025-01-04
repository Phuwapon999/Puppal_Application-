// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

List<LoginData> loginDataFromJson(String str) =>
    List<LoginData>.from(json.decode(str).map((x) => LoginData.fromJson(x)));

String loginDataToJson(List<LoginData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginData {
  String email;
  String password;

  LoginData({
    required this.email,
    required this.password,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
