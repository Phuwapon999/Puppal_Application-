// To parse this JSON data, do
//
//     final reserveData = reserveDataFromJson(jsonString);

import 'dart:convert';

List<ReserveData> reserveDataFromJson(String str) => List<ReserveData>.from(
    json.decode(str).map((x) => ReserveData.fromJson(x)));

String reserveDataToJson(List<ReserveData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReserveData {
  int rid;
  int dRid;
  String dogPic;
  String dogname;
  String ownername;
  String owmerPic;
  String date;
  int status;

  ReserveData({
    required this.rid,
    required this.dRid,
    required this.dogPic,
    required this.dogname,
    required this.ownername,
    required this.owmerPic,
    required this.date,
    required this.status,
  });

  factory ReserveData.fromJson(Map<String, dynamic> json) => ReserveData(
        rid: json["rid"],
        dRid: json["d_rid"],
        dogPic: json["dogPic"],
        dogname: json["dogname"],
        ownername: json["ownername"],
        owmerPic: json["owmerPic"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "rid": rid,
        "d_rid": dRid,
        "dogPic": dogPic,
        "dogname": dogname,
        "ownername": ownername,
        "owmerPic": owmerPic,
        "date": date,
        "status": status,
      };
}
