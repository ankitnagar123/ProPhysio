// To parse this JSON data, do
//
//     final doctorViewMsgList = doctorViewMsgListFromJson(jsonString);

import 'dart:convert';

List<DoctorViewMsgList> doctorViewMsgListFromJson(String str) => List<DoctorViewMsgList>.from(json.decode(str).map((x) => DoctorViewMsgList.fromJson(x)));

String doctorViewMsgListToJson(List<DoctorViewMsgList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorViewMsgList {
  String id;
  String message;
  String upstatus;
  String sentat;
  String date;

  DoctorViewMsgList({
    required this.id,
    required this.message,
    required this.upstatus,
    required this.sentat,
    required this.date,
  });

  factory DoctorViewMsgList.fromJson(Map<String, dynamic> json) => DoctorViewMsgList(
    id: json["id"],
    message: json["message"],
    upstatus: json["upstatus"],
    sentat: json["sentat"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "upstatus": upstatus,
    "sentat": sentat,
    "date": date,
  };
}
