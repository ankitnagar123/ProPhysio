// To parse this JSON data, do
//
//     final calenderDateShowModel = calenderDateShowModelFromJson(jsonString);

import 'dart:convert';

List<CalenderDateShowModel> calenderDateShowModelFromJson(String str) => List<CalenderDateShowModel>.from(json.decode(str).map((x) => CalenderDateShowModel.fromJson(x)));

String calenderDateShowModelToJson(List<CalenderDateShowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalenderDateShowModel {
  CalenderDateShowModel({
    required this.percent,
    required this.day,
    required this.month,
    required this.year,
  });

  String percent;
  String day;
  String month;
  String year;

  factory CalenderDateShowModel.fromJson(Map<String, dynamic> json) => CalenderDateShowModel(
    percent: json["percent"],
    day: json["day"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "percent": percent,
    "day": day,
    "month": month,
    "year": year,
  };
}
