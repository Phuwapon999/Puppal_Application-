// To parse this JSON data, do
//
//     final doctorReserveData = doctorReserveDataFromJson(jsonString);

import 'dart:convert';

List<DoctorReserveData> doctorReserveDataFromJson(String str) =>
    List<DoctorReserveData>.from(
        json.decode(str).map((x) => DoctorReserveData.fromJson(x)));

String doctorReserveDataToJson(List<DoctorReserveData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorReserveData {
  String date;

  DoctorReserveData({
    required this.date,
  });

  factory DoctorReserveData.fromJson(Map<String, dynamic> json) =>
      DoctorReserveData(
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
      };
}
