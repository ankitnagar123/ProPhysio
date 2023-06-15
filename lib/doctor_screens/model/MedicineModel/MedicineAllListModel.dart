// To parse this JSON data, do
//
//     final medicineAllListModel = medicineAllListModelFromJson(jsonString);

import 'dart:convert';

List<MedicineAllListModel> medicineAllListModelFromJson(String str) => List<MedicineAllListModel>.from(json.decode(str).map((x) => MedicineAllListModel.fromJson(x)));

String medicineAllListModelToJson(List<MedicineAllListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicineAllListModel {
  String medicineId;
  String madcine;
  String medicineName;

  MedicineAllListModel({
    required this.medicineId,
    required this.madcine,
    required this.medicineName,
  });

  factory MedicineAllListModel.fromJson(Map<String, dynamic> json) => MedicineAllListModel(
    medicineId: json["medicine_id"],
    madcine: json["madcine"],
    medicineName: json["medicine_name"],
  );

  Map<String, dynamic> toJson() => {
    "medicine_id": medicineId,
    "madcine": madcine,
    "medicine_name": medicineName,
  };
}
