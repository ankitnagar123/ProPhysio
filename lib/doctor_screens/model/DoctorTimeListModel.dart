// To parse this JSON data, do
//
//     final doctorTimeListModel = doctorTimeListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorTimeListModel> doctorTimeListModelFromJson(String str) => List<DoctorTimeListModel>.from(json.decode(str).map((x) => DoctorTimeListModel.fromJson(x)));

String doctorTimeListModelToJson(List<DoctorTimeListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorTimeListModel {
  DoctorTimeListModel({
    required this.id,
    required this.from,
    required this.to,
  });

  String id;
  String from;
  String to;

  factory DoctorTimeListModel.fromJson(Map<String, dynamic> json) => DoctorTimeListModel(
    id: json["Id"],
    from: json["From"],
    to: json["To"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "From": from,
    "To": to,
  };
}
