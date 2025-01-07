// To parse this JSON data, do
//
//     final reserveInput = reserveInputFromJson(jsonString);

import 'dart:convert';

ReserveInput reserveInputFromJson(String str) =>
    ReserveInput.fromJson(json.decode(str));

String reserveInputToJson(ReserveInput data) => json.encode(data.toJson());

class ReserveInput {
  int uRid;
  int docRid;
  int dRid;
  DateTime date;

  ReserveInput({
    required this.uRid,
    required this.docRid,
    required this.dRid,
    required this.date,
  });

  factory ReserveInput.fromJson(Map<String, dynamic> json) => ReserveInput(
        uRid: json["u_rid"],
        docRid: json["doc_rid"],
        dRid: json["d_rid"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "u_rid": uRid,
        "doc_rid": docRid,
        "d_rid": dRid,
        "date": date.toIso8601String(),
      };
}
