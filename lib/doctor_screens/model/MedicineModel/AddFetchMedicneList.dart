// To parse this JSON data, do
//
//     final addFetchMedicineListModel = addFetchMedicineListModelFromJson(jsonString);

import 'dart:convert';

AddFetchMedicineListModel addFetchMedicineListModelFromJson(String str) => AddFetchMedicineListModel.fromJson(json.decode(str));

String addFetchMedicineListModelToJson(AddFetchMedicineListModel data) => json.encode(data.toJson());

class AddFetchMedicineListModel {
  String pdf;
  List<Detail> details;

  AddFetchMedicineListModel({
    required this.pdf,
    required this.details,
  });

  factory AddFetchMedicineListModel.fromJson(Map<String, dynamic> json) => AddFetchMedicineListModel(
    pdf: json["PDF"],
    details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PDF": pdf,
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  String medicineId;
  String madcine;
  String? medicineName;
  String medicineTiming;
  String medicineSlot;
  String description;

  Detail({
    required this.medicineId,
    required this.madcine,
    this.medicineName,
    required this.medicineTiming,
    required this.medicineSlot,
    required this.description,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
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
