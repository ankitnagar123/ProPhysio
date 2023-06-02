// To parse this JSON data, do
//
//     final prescriptionReportQrModel = prescriptionReportQrModelFromJson(jsonString);

import 'dart:convert';

List<PrescriptionReportQrModel> prescriptionReportQrModelFromJson(String str) => List<PrescriptionReportQrModel>.from(json.decode(str).map((x) => PrescriptionReportQrModel.fromJson(x)));

String prescriptionReportQrModelToJson(List<PrescriptionReportQrModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrescriptionReportQrModel {
  String result;
  String userId;
  String doctorId;
  String doctorName;
  String doctorSurname;
  String title;
  String type;
  String description;
  String image;

  PrescriptionReportQrModel({
    required this.result,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSurname,
    required this.title,
    required this.type,
    required this.description,
    required this.image,
  });

  factory PrescriptionReportQrModel.fromJson(Map<String, dynamic> json) => PrescriptionReportQrModel(
    result: json["result"],
    userId: json["user_id"],
    doctorId: json["doctor_id"],
    doctorName: json["doctor_name"],
    doctorSurname: json["doctor_surname"],
    title: json["title"],
    type: json["type"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "user_id": userId,
    "doctor_id": doctorId,
    "doctor_name": doctorName,
    "doctor_surname": doctorSurname,
    "title": title,
    "type": type,
    "description": description,
    "image": image,
  };
}
