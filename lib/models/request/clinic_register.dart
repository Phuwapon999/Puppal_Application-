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
  String clinicname;
  String nameSurname;
  String phone;
  String email;
  String password;
  String profileClinicPic;
  String lat;
  String lng;

  ClinicRegister({
    required this.clinicname,
    required this.nameSurname,
    required this.phone,
    required this.email,
    required this.password,
    required this.profileClinicPic,
    required this.lat,
    required this.lng,
  });

  factory ClinicRegister.fromJson(Map<String, dynamic> json) => ClinicRegister(
        clinicname: json["clinicname"],
        nameSurname: json["nameSurname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        profileClinicPic: json["profileClinicPic"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "clinicname": clinicname,
        "nameSurname": nameSurname,
        "phone": phone,
        "email": email,
        "password": password,
        "profileClinicPic": profileClinicPic,
        "lat": lat,
        "lng": lng,
      };
}
