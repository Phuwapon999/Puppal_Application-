// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  int uid;
  dynamic username;
  dynamic clinicname;
  String nameSurname;
  String phone;
  String email;
  String password;
  dynamic profilePic;
  dynamic profileClinicPic;
  dynamic lat;
  dynamic lng;
  dynamic doctorPic;
  int followers;
  int followersClinic;

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
