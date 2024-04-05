// To parse this JSON data, do
//
//     final complaintsModel = complaintsModelFromJson(jsonString);

import 'dart:convert';

List<ComplaintsModel> complaintsModelFromJson(String str) => List<ComplaintsModel>.from(json.decode(str).map((x) => ComplaintsModel.fromJson(x)));

String complaintsModelToJson(List<ComplaintsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintsModel {
  String supportId;
  String patientId;
  String patientName;
  String subject;
  String email;
  String message;
  String status;
  String date;

  ComplaintsModel({
    required this.supportId,
    required this.patientId,
    required this.patientName,
    required this.subject,
    required this.email,
    required this.message,
    required this.status,
    required this.date,
  });

  factory ComplaintsModel.fromJson(Map<String, dynamic> json) => ComplaintsModel(
    supportId: json["support_id"],
    patientId: json["patient_id"],
    patientName: json["patient_name"],
    subject: json["subject"],
    email: json["email"],
    message: json["message"],
    status: json["status"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "support_id": supportId,
    "patient_id": patientId,
    "patient_name": patientName,
    "subject": subject,
    "email": email,
    "message": message,
    "status": status,
    "date": date,
  };
}
