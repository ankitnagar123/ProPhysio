// To parse this JSON data, do
//
//     final visitChargeModel = visitChargeModelFromJson(jsonString);

import 'dart:convert';

List<VisitChargeModel> visitChargeModelFromJson(String str) => List<VisitChargeModel>.from(json.decode(str).map((x) => VisitChargeModel.fromJson(x)));

String visitChargeModelToJson(List<VisitChargeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VisitChargeModel {
  String title;
  String description;
  String price;

  VisitChargeModel({
    required this.title,
    required this.description,
    required this.price,
  });

  factory VisitChargeModel.fromJson(Map<String, dynamic> json) => VisitChargeModel(
    title: json["title"].toString(),
    description: json["description"].toString(),
    price: json["price"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "price": price,
  };
}
