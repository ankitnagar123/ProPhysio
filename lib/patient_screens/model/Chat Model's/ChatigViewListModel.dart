// To parse this JSON data, do
//
//     final pChatingViewListModel = pChatingViewListModelFromJson(jsonString);

import 'dart:convert';

List<PChatingViewListModel> pChatingViewListModelFromJson(String str) => List<PChatingViewListModel>.from(json.decode(str).map((x) => PChatingViewListModel.fromJson(x)));

String pChatingViewListModelToJson(List<PChatingViewListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PChatingViewListModel {
  String id;
  String type;
  String message;
  String upstatus;
  String sentat;
  String date;

  PChatingViewListModel({
    required this.id,
    required this.type,
    required this.message,
    required this.upstatus,
    required this.sentat,
    required this.date,
  });

  factory PChatingViewListModel.fromJson(Map<String, dynamic> json) => PChatingViewListModel(
    id: json["id"],
    type: json["type"],
    message: json["message"],
    upstatus: json["upstatus"],
    sentat: json["sentat"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "message": message,
    "upstatus": upstatus,
    "sentat": sentat,
    "date": date,
  };
}
