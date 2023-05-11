// To parse this JSON data, do
//
//     final allCategoryModel = allCategoryModelFromJson(jsonString);

import 'dart:convert';

List<AllCategoryModel> allCategoryModelFromJson(String str) => List<AllCategoryModel>.from(json.decode(str).map((x) => AllCategoryModel.fromJson(x)));

String allCategoryModelToJson(List<AllCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCategoryModel {
  AllCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required  this.catImg,
  });

  String categoryId;
  String categoryName;
  String catImg;

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) => AllCategoryModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    catImg: json["cat_img"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "cat_img": catImg,
  };
}
