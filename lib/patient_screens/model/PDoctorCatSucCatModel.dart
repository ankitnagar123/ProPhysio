// To parse this JSON data, do
//
//     final allCatSucCatModel = allCatSucCatModelFromJson(jsonString);

import 'dart:convert';

List<AllCatSucCatModel> allCatSucCatModelFromJson(String str) => List<AllCatSucCatModel>.from(json.decode(str).map((x) => AllCatSucCatModel.fromJson(x)));

String allCatSucCatModelToJson(List<AllCatSucCatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCatSucCatModel {
  AllCatSucCatModel({
    required this.categoryId,
    required this.categoryName,
    required this.catImg,
    required  this.subCatDetail,
  });

  String categoryId;
  String categoryName;
  String catImg;
  List<SubCatDetail> subCatDetail;

  factory AllCatSucCatModel.fromJson(Map<String, dynamic> json) => AllCatSucCatModel(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    catImg: json["cat_img"],
    subCatDetail: List<SubCatDetail>.from(json["sub_cat_detail"].map((x) => SubCatDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "cat_img": catImg,
    "sub_cat_detail": List<dynamic>.from(subCatDetail.map((x) => x.toJson())),
  };
}

class SubCatDetail {
  SubCatDetail({
    required this.subcatId,
    required this.subcatName,
    required this.subcatImg,
  });

  String subcatId;
  String subcatName;
  String subcatImg;

  factory SubCatDetail.fromJson(Map<String, dynamic> json) => SubCatDetail(
    subcatId: json["subcat_id"],
    subcatName: json["subcat_name"],
    subcatImg: json["subcat_img"],
  );

  Map<String, dynamic> toJson() => {
    "subcat_id": subcatId,
    "subcat_name": subcatName,
    "subcat_img": subcatImg,
  };
}
