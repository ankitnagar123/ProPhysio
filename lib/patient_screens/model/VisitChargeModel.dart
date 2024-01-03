// To parse this JSON data, do
//
//     final visitChargeModel = visitChargeModelFromJson(jsonString);

import 'dart:convert';

List<VisitChargeModel> visitChargeModelFromJson(String str) => List<VisitChargeModel>.from(json.decode(str).map((x) => VisitChargeModel.fromJson(x)));

String visitChargeModelToJson(List<VisitChargeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VisitChargeModel {
  String categoryName;
  String price;

  VisitChargeModel({
    required this.categoryName,
    required this.price,
  });

  factory VisitChargeModel.fromJson(Map<String, dynamic> json) => VisitChargeModel(
    categoryName: json["category_name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "price": price,
  };
}
