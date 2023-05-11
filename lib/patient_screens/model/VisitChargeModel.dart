// To parse this JSON data, do
//
//     final visitChargeModel = visitChargeModelFromJson(jsonString);

import 'dart:convert';

List<VisitChargeModel> visitChargeModelFromJson(String str) => List<VisitChargeModel>.from(json.decode(str).map((x) => VisitChargeModel.fromJson(x)));

String visitChargeModelToJson(List<VisitChargeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VisitChargeModel {
  VisitChargeModel({
    required this.name,
    required this.price,
  });

  String name;
  String price;

  factory VisitChargeModel.fromJson(Map<String, dynamic> json) => VisitChargeModel(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}
