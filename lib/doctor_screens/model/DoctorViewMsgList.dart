// To parse this JSON data, do
//
//     final doctorViewMsgList = doctorViewMsgListFromJson(jsonString);

import 'dart:convert';

List<DoctorViewMsgList> doctorViewMsgListFromJson(String str) => List<DoctorViewMsgList>.from(json.decode(str).map((x) => DoctorViewMsgList.fromJson(x)));

String doctorViewMsgListToJson(List<DoctorViewMsgList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorViewMsgList {
  String id;
  String type;
  String message;
  String upstatus;
  String sentat;
  String date;

  DoctorViewMsgList({
    required this.id,
    required this.type,
    required this.message,
    required this.upstatus,
    required this.sentat,
    required this.date,
  });

  factory DoctorViewMsgList.fromJson(Map<String, dynamic> json) => DoctorViewMsgList(
    id: json["id"].toString(),
    type: json["type"].toString(),
    message: json["message"].toString(),
    upstatus: json["upstatus"].toString(),
    sentat: json["sentat"].toString(),
    date: json["date"].toString(),
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
