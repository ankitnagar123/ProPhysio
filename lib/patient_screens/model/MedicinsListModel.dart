// To parse this JSON data, do
//
//     final patinetMedicineListModel = patinetMedicineListModelFromJson(jsonString);

import 'dart:convert';

List<PatinetMedicineListModel> patinetMedicineListModelFromJson(String str) => List<PatinetMedicineListModel>.from(json.decode(str).map((x) => PatinetMedicineListModel.fromJson(x)));

String patinetMedicineListModelToJson(List<PatinetMedicineListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatinetMedicineListModel {
  String doctorName;
  String doctorSurname;
  String medicineId;
  String madcine;
  String? medicineName;
  String medicineTiming;
  String medicineSlot;
  String description;

  PatinetMedicineListModel({
    required this.doctorName,
    required this.doctorSurname,
    required this.medicineId,
    required this.madcine,
    this.medicineName,
    required this.medicineTiming,
    required this.medicineSlot,
    required this.description,
  });

  factory PatinetMedicineListModel.fromJson(Map<String, dynamic> json) => PatinetMedicineListModel(
    doctorName: json["doctor_name"],
    doctorSurname: json["doctor_surname"],
    medicineId: json["medicine_id"],
    madcine: json["madcine"],
    medicineName: json["medicine_name"],
    medicineTiming: json["medicine_timing"],
    medicineSlot: json["medicine_slot"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_name": doctorName,
    "doctor_surname": doctorSurname,
    "medicine_id": medicineId,
    "madcine": madcine,
    "medicine_name": medicineName,
    "medicine_timing": medicineTiming,
    "medicine_slot": medicineSlotValues.reverse[medicineSlot],
    "description": description,
  };
}

enum MedicineSlot { BEFORE_MEAL, AFTER_MEAL, EMPTY, MEDICINE_SLOT_AFTER_MEAL }

final medicineSlotValues = EnumValues({
  "After Meal": MedicineSlot.AFTER_MEAL,
  "Before Meal": MedicineSlot.BEFORE_MEAL,
  "": MedicineSlot.EMPTY,
  "after_meal": MedicineSlot.MEDICINE_SLOT_AFTER_MEAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
