// To parse this JSON data, do
//
//     final calenderDateShowModel = calenderDateShowModelFromJson(jsonString);

import 'dart:convert';

List<CalenderDateShowModel> calenderDateShowModelFromJson(String str) => List<CalenderDateShowModel>.from(json.decode(str).map((x) => CalenderDateShowModel.fromJson(x)));

String calenderDateShowModelToJson(List<CalenderDateShowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalenderDateShowModel {
  String day;
  String month;
  String year;
  String status;

  CalenderDateShowModel({
    required this.day,
    required this.month,
    required this.year,
    required this.status,
  });

  factory CalenderDateShowModel.fromJson(Map<String, dynamic> json) => CalenderDateShowModel(
    day: json["day"],
    month: json["month"],
    year: json["year"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "month": month,
    "year": year,
    "status": status,
  };
}
