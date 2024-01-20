// To parse this JSON data, do
//
//     final doctorTimeSlotModel = doctorTimeSlotModelFromJson(jsonString);

import 'dart:convert';

List<DoctorTimeSlotModel> doctorTimeSlotModelFromJson(String str) => List<DoctorTimeSlotModel>.from(json.decode(str).map((x) => DoctorTimeSlotModel.fromJson(x)));

String doctorTimeSlotModelToJson(List<DoctorTimeSlotModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorTimeSlotModel {
  String timeslot;

  DoctorTimeSlotModel({
    required this.timeslot,
  });

  factory DoctorTimeSlotModel.fromJson(Map<String, dynamic> json) => DoctorTimeSlotModel(
    timeslot: json["Timeslot"],
  );

  Map<String, dynamic> toJson() => {
    "Timeslot": timeslot,
  };
}
