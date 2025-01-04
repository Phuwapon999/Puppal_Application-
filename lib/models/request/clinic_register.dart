// To parse this JSON data, do
//
//     final clinicRegister = clinicRegisterFromJson(jsonString);

import 'dart:convert';

List<ClinicRegister> clinicRegisterFromJson(String str) =>
    List<ClinicRegister>.from(
        json.decode(str).map((x) => ClinicRegister.fromJson(x)));

String clinicRegisterToJson(List<ClinicRegister> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClinicRegister {
  String username;
  String nameSurname;
  String phone;
  String email;
  String password;
  String profilePic;
  String lat;
  String lng;
  int type;

  ClinicRegister({
    required this.username,
    required this.nameSurname,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.lat,
    required this.lng,
    required this.type,
  });

  factory ClinicRegister.fromJson(Map<String, dynamic> json) => ClinicRegister(
        username: json["username"],
        nameSurname: json["nameSurname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        lat: json["lat"],
        lng: json["lng"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "nameSurname": nameSurname,
        "phone": phone,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "lat": lat,
        "lng": lng,
        "type": type,
      };
}
