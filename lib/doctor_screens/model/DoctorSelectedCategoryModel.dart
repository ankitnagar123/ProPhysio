// To parse this JSON data, do
//
//     final selectedCategoryModel = selectedCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SelectedCategoryModel> selectedCategoryModelFromJson(String str) => List<SelectedCategoryModel>.from(json.decode(str).map((x) => SelectedCategoryModel.fromJson(x)));

String selectedCategoryModelToJson(List<SelectedCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedCategoryModel {
  SelectedCategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  String categoryId;
  String categoryName;

  factory SelectedCategoryModel.fromJson(Map<String, dynamic> json) => SelectedCategoryModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}
