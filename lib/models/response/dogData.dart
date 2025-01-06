// To parse this JSON data, do
//
//     final dogData = dogDataFromJson(jsonString);

import 'dart:convert';

List<DogData> dogDataFromJson(String str) =>
    List<DogData>.from(json.decode(str).map((x) => DogData.fromJson(x)));

String dogDataToJson(List<DogData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DogData {
  int did;
  int bDid;
  int uDid;
  String name;
  String gender;
  String color;
  String? defect;
  String birth;
  String? conDisease;
  String? vacHistory;
  int? sterilization;
  String pic;
  String? hair;
  int status;
  String dogName;
  String breed;

  DogData({
    required this.did,
    required this.bDid,
    required this.uDid,
    required this.name,
    required this.gender,
    required this.color,
    required this.defect,
    required this.birth,
    required this.conDisease,
    required this.vacHistory,
    required this.sterilization,
    required this.pic,
    required this.hair,
    required this.status,
    required this.dogName,
    required this.breed,
  });

  factory DogData.fromJson(Map<String, dynamic> json) => DogData(
        did: json["did"],
        bDid: json["b_did"],
        uDid: json["u_did"],
        name: json["name"],
        gender: json["gender"],
        color: json["color"],
        defect: json["defect"],
        birth: json["birth"],
        conDisease: json["conDisease"],
        vacHistory: json["vacHistory"],
        sterilization: json["sterilization"],
        pic: json["pic"],
        hair: json["hair"],
        status: json["status"],
        dogName: json["dogName"],
        breed: json["breed"],
      );

  Map<String, dynamic> toJson() => {
        "did": did,
        "b_did": bDid,
        "u_did": uDid,
        "name": name,
        "gender": gender,
        "color": color,
        "defect": defect,
        "birth": birth,
        "conDisease": conDisease,
        "vacHistory": vacHistory,
        "sterilization": sterilization,
        "pic": pic,
        "hair": hair,
        "status": status,
        "dogName": dogName,
        "breed": breed,
      };
}
