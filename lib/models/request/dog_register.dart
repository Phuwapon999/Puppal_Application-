// To parse this JSON data, do
//
//     final dogRegister = dogRegisterFromJson(jsonString);

import 'dart:convert';

DogRegister dogRegisterFromJson(String str) =>
    DogRegister.fromJson(json.decode(str));

String dogRegisterToJson(DogRegister data) => json.encode(data.toJson());

class DogRegister {
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

  DogRegister({
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
  });

  factory DogRegister.fromJson(Map<String, dynamic> json) => DogRegister(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
