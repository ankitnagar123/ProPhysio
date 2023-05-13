// To parse this JSON data, do
//
//     final centerSelectedDWardModel = centerSelectedDWardModelFromJson(jsonString);

import 'dart:convert';

List<CenterSelectedDWardModel> centerSelectedDWardModelFromJson(String str) => List<CenterSelectedDWardModel>.from(json.decode(str).map((x) => CenterSelectedDWardModel.fromJson(x)));

String centerSelectedDWardModelToJson(List<CenterSelectedDWardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CenterSelectedDWardModel {
  String wardId;
  String name;
  int totalDoctor;

  CenterSelectedDWardModel({
    required this.wardId,
    required this.name,
    required this.totalDoctor,
  });

  factory CenterSelectedDWardModel.fromJson(Map<String, dynamic> json) => CenterSelectedDWardModel(
    wardId: json["ward_id"],
    name: json["name"],
    totalDoctor: json["total_doctor"],
  );

  Map<String, dynamic> toJson() => {
    "ward_id": wardId,
    "name": name,
    "total_doctor": totalDoctor,
  };
}
