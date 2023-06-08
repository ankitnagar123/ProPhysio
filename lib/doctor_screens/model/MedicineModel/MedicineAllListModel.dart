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
  String medicineTiming;
  String medicineSlot;
  String description;

  MedicineAllListModel({
    required this.medicineId,
    required this.madcine,
    required this.medicineName,
    required this.medicineTiming,
    required this.medicineSlot,
    required this.description,
  });

  factory MedicineAllListModel.fromJson(Map<String, dynamic> json) => MedicineAllListModel(
    medicineId: json["medicine_id"],
    madcine: json["madcine"],
    medicineName: json["medicine_name"],
    medicineTiming: json["medicine_timing"],
    medicineSlot: json["medicine_slot"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "medicine_id": medicineId,
    "madcine": madcine,
    "medicine_name": medicineName,
    "medicine_timing": medicineTiming,
    "medicine_slot": medicineSlot,
    "description": description,
  };
}
