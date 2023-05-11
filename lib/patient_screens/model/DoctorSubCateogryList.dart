// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromJson(String str) => List<SubCategoryModel>.from(json.decode(str).map((x) => SubCategoryModel.fromJson(x)));

String subCategoryModelToJson(List<SubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModel {
  SubCategoryModel({
    required this.subcatId,
    required this.subcatName,
    required this.image,
    required this.subcatImg,
  });

  String subcatId;
  String subcatName;
  String image;
  String subcatImg;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    subcatId: json["subcat_id"],
    subcatName: json["subcat_name"],
    image: json["Image"],
    subcatImg: json["subcat_img"],
  );

  Map<String, dynamic> toJson() => {
    "subcat_id": subcatId,
    "subcat_name": subcatName,
    "Image": image,
    "subcat_img": subcatImg,
  };
}
