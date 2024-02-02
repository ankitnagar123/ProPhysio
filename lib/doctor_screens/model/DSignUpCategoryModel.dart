// To parse this JSON data, do
//
//     final allCategoryModel = allCategoryModelFromJson(jsonString);

import 'dart:convert';

List<AllCategoryModel> allCategoryModelFromJson(String str) => List<AllCategoryModel>.from(json.decode(str).map((x) => AllCategoryModel.fromJson(x)));

String allCategoryModelToJson(List<AllCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCategoryModel {
  String categoryId;
  String categoryName;
  String categoryPrice;
  String catImg;

  AllCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryPrice,
    required this.catImg,
  });

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) => AllCategoryModel(
    categoryId: json["category_id"].toString(),
    categoryName: json["category_name"].toString(),
    categoryPrice: json["category_price"].toString(),
    catImg: json["cat_img"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_price": categoryPrice,
    "cat_img": catImg,
  };
}
