// To parse this JSON data, do
//
//     final reserveDataUser = reserveDataUserFromJson(jsonString);

import 'dart:convert';

List<ReserveDataUser> reserveDataUserFromJson(String str) =>
    List<ReserveDataUser>.from(
        json.decode(str).map((x) => ReserveDataUser.fromJson(x)));

String reserveDataUserToJson(List<ReserveDataUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReserveDataUser {
  int rid;
  String clinicname;
  String profileClinicPic;
  String name;
  String dogPic;
  String date;
  int status;
  String lat;
  String lng;
  int dRid;

  ReserveDataUser({
    required this.rid,
    required this.clinicname,
    required this.profileClinicPic,
    required this.name,
    required this.dogPic,
    required this.date,
    required this.status,
    required this.lat,
    required this.lng,
    required this.dRid,
  });

  factory ReserveDataUser.fromJson(Map<String, dynamic> json) =>
      ReserveDataUser(
        rid: json["rid"],
        clinicname: json["clinicname"],
        profileClinicPic: json["profileClinicPic"],
        name: json["name"],
        dogPic: json["dogPic"],
        date: json["date"],
        status: json["status"],
        lat: json["lat"],
        lng: json["lng"],
        dRid: json["d_rid"],
      );

  Map<String, dynamic> toJson() => {
        "rid": rid,
        "clinicname": clinicname,
        "profileClinicPic": profileClinicPic,
        "name": name,
        "dogPic": dogPic,
        "date": date,
        "status": status,
        "lat": lat,
        "lng": lng,
        "d_rid": dRid,
      };
}
