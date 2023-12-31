// To parse this JSON data, do
//
//     final patinetPrescriptionModel = patinetPrescriptionModelFromJson(jsonString);

import 'dart:convert';

List<PatinetPrescriptionModel> patinetPrescriptionModelFromJson(String str) => List<PatinetPrescriptionModel>.from(json.decode(str).map((x) => PatinetPrescriptionModel.fromJson(x)));

String patinetPrescriptionModelToJson(List<PatinetPrescriptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatinetPrescriptionModel {
  PatinetPrescriptionModel({
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


  factory PatinetPrescriptionModel.fromJson(Map<String, dynamic> json) => PatinetPrescriptionModel(
    result: json["result"].toString(),
    userId: json["user_id"].toString(),
    doctorId: json["doctor_id"].toString(),
    doctorName: json["doctor_name"].toString(),
    doctorSurname: json["doctor_surname"].toString(),
    title: json["title"].toString(),
    type: json["type"].toString(),
    description: json["description"].toString(),
    image: json["image"].toString(),
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
