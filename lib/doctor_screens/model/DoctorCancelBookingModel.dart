// To parse this JSON data, do
//
//     final doctorBookingCancelModel = doctorBookingCancelModelFromJson(jsonString);

import 'dart:convert';

List<DoctorBookingCancelModel> doctorBookingCancelModelFromJson(String str) => List<DoctorBookingCancelModel>.from(json.decode(str).map((x) => DoctorBookingCancelModel.fromJson(x)));

String doctorBookingCancelModelToJson(List<DoctorBookingCancelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorBookingCancelModel {
  DoctorBookingCancelModel({
    required this.id,
    required this.reason,
  });

  String id;
  String reason;

  factory DoctorBookingCancelModel.fromJson(Map<String, dynamic> json) => DoctorBookingCancelModel(
    id: json["id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  };
}
