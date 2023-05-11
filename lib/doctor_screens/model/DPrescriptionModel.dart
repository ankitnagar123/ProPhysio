// To parse this JSON data, do
//
//     final dPrescriptionListModel = dPrescriptionListModelFromJson(jsonString);

import 'dart:convert';

List<DPrescriptionListModel> dPrescriptionListModelFromJson(String str) => List<DPrescriptionListModel>.from(json.decode(str).map((x) => DPrescriptionListModel.fromJson(x)));

String dPrescriptionListModelToJson(List<DPrescriptionListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DPrescriptionListModel {
  DPrescriptionListModel({
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

  String result;
  String userId;
  String doctorId;
  String doctorName;
  String doctorSurname;
  String title;
  String type;
  String description;
  String image;

  factory DPrescriptionListModel.fromJson(Map<String, dynamic> json) => DPrescriptionListModel(
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
