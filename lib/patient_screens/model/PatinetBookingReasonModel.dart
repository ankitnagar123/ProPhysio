// To parse this JSON data, do
//
//     final patientBookingCancelModel = patientBookingCancelModelFromJson(jsonString);

import 'dart:convert';

List<PatientBookingCancelModel> patientBookingCancelModelFromJson(String str) => List<PatientBookingCancelModel>.from(json.decode(str).map((x) => PatientBookingCancelModel.fromJson(x)));

String patientBookingCancelModelToJson(List<PatientBookingCancelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientBookingCancelModel {
  PatientBookingCancelModel({
    required this.id,
    required this.reason,
  });

  String id;
  String reason;

  factory PatientBookingCancelModel.fromJson(Map<String, dynamic> json) => PatientBookingCancelModel(
    id: json["id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  };
}
