// To parse this JSON data, do
//
//     final addFetchMedicineListModel = addFetchMedicineListModelFromJson(jsonString);

import 'dart:convert';

List<AddFetchMedicineListModel> addFetchMedicineListModelFromJson(String str) => List<AddFetchMedicineListModel>.from(json.decode(str).map((x) => AddFetchMedicineListModel.fromJson(x)));

String addFetchMedicineListModelToJson(List<AddFetchMedicineListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddFetchMedicineListModel {
  String medicineId;
  String madcine;
  String medicineName;
  String medicineTiming;
  String medicineSlot;
  String description;

  AddFetchMedicineListModel({
    required this.medicineId,
    required this.madcine,
    required this.medicineName,
    required this.medicineTiming,
    required this.medicineSlot,
    required this.description,
  });

  factory AddFetchMedicineListModel.fromJson(Map<String, dynamic> json) => AddFetchMedicineListModel(
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
