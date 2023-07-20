// To parse this JSON data, do
//
//     final patinetMedicineListModel = patinetMedicineListModelFromJson(jsonString);

import 'dart:convert';

List<PatinetMedicineListModel> patinetMedicineListModelFromJson(String str) => List<PatinetMedicineListModel>.from(json.decode(str).map((x) => PatinetMedicineListModel.fromJson(x)));

String patinetMedicineListModelToJson(List<PatinetMedicineListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatinetMedicineListModel {
  String doctorId;
  String doctorName;
  String doctorSurname;

  PatinetMedicineListModel({
    required this.doctorId,
    required this.doctorName,
    required this.doctorSurname,
  });

  factory PatinetMedicineListModel.fromJson(Map<String, dynamic> json) => PatinetMedicineListModel(
    doctorId: json["doctor_id"],
    doctorName: json["doctor_name"],
    doctorSurname: json["doctor_surname"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "doctor_name": doctorName,
    "doctor_surname": doctorSurname,
  };
}
