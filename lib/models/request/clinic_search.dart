// To parse this JSON data, do
//
//     final searchClinic = searchClinicFromJson(jsonString);

import 'dart:convert';

List<SearchClinic> searchClinicFromJson(String str) => List<SearchClinic>.from(
    json.decode(str).map((x) => SearchClinic.fromJson(x)));

String searchClinicToJson(List<SearchClinic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchClinic {
  int uid;
  String? username;
  String clinicname;
  String nameSurname;
  String phone;
  String email;
  String password;
  String? profilePic;
  String profileClinicPic;
  String lat;
  String lng;
  dynamic doctorPic;
  int followers;
  int followersClinic;

  SearchClinic({
    required this.uid,
    required this.username,
    required this.clinicname,
    required this.nameSurname,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.profileClinicPic,
    required this.lat,
    required this.lng,
    required this.doctorPic,
    required this.followers,
    required this.followersClinic,
  });

  factory SearchClinic.fromJson(Map<String, dynamic> json) => SearchClinic(
        uid: json["uid"],
        username: json["username"],
        clinicname: json["clinicname"],
        nameSurname: json["nameSurname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        profileClinicPic: json["profileClinicPic"],
        lat: json["lat"],
        lng: json["lng"],
        doctorPic: json["doctorPic"],
        followers: json["followers"],
        followersClinic: json["followersClinic"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "clinicname": clinicname,
        "nameSurname": nameSurname,
        "phone": phone,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "profileClinicPic": profileClinicPic,
        "lat": lat,
        "lng": lng,
        "doctorPic": doctorPic,
        "followers": followers,
        "followersClinic": followersClinic,
      };
}
