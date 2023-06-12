// To parse this JSON data, do
//
//     final doctorTimeListModel = doctorTimeListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorTimeListModel> doctorTimeListModelFromJson(String str) => List<DoctorTimeListModel>.from(json.decode(str).map((x) => DoctorTimeListModel.fromJson(x)));

String doctorTimeListModelToJson(List<DoctorTimeListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorTimeListModel {
  String timeId;
  String from;
  String to;

  DoctorTimeListModel({
    required this.timeId,
    required this.from,
    required this.to,
  });

  factory DoctorTimeListModel.fromJson(Map<String, dynamic> json) => DoctorTimeListModel(
    timeId: json["time_id"],
    from: json["From"],
    to: json["To"],
  );

  Map<String, dynamic> toJson() => {
    "time_id": timeId,
    "From": from,
    "To": to,
  };
}
