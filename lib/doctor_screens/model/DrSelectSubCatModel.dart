// To parse this JSON data, do
//
//     final selectedSubCategoryModel = selectedSubCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SelectedSubCategoryModel> selectedSubCategoryModelFromJson(String str) => List<SelectedSubCategoryModel>.from(json.decode(str).map((x) => SelectedSubCategoryModel.fromJson(x)));

String selectedSubCategoryModelToJson(List<SelectedSubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedSubCategoryModel {
  SelectedSubCategoryModel({
    required this.subcatId,
    required this.subcatName,
  });

  String subcatId;
  String subcatName;

  factory SelectedSubCategoryModel.fromJson(Map<String, dynamic> json) => SelectedSubCategoryModel(
    subcatId: json["subcat_id"],
    subcatName: json["subcat_name"],
  );

  Map<String, dynamic> toJson() => {
    "subcat_id": subcatId,
    "subcat_name": subcatName,
  };
}
