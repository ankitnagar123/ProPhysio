// To parse this JSON data, do
//
//     final doctorSpecializationModel = doctorSpecializationModelFromJson(jsonString);

import 'dart:convert';

List<DoctorSpecializationModel> doctorSpecializationModelFromJson(String str) => List<DoctorSpecializationModel>.from(json.decode(str).map((x) => DoctorSpecializationModel.fromJson(x)));

String doctorSpecializationModelToJson(List<DoctorSpecializationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorSpecializationModel {
  DoctorSpecializationModel({
    required this.categoryId,
    required this.categoryName,
  });

  String categoryId;
  String categoryName;

  factory DoctorSpecializationModel.fromJson(Map<String, dynamic> json) => DoctorSpecializationModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}
