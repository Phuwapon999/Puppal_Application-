// To parse this JSON data, do
//
//     final breedData = breedDataFromJson(jsonString);

import 'dart:convert';

List<BreedData> breedDataFromJson(String str) =>
    List<BreedData>.from(json.decode(str).map((x) => BreedData.fromJson(x)));

String breedDataToJson(List<BreedData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BreedData {
  int bid;
  String name;

  BreedData({
    required this.bid,
    required this.name,
  });

  factory BreedData.fromJson(Map<String, dynamic> json) => BreedData(
        bid: json["bid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "name": name,
      };
}
