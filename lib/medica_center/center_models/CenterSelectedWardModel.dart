// To parse this JSON data, do
//
//     final centerSelectedDWardModel = centerSelectedDWardModelFromJson(jsonString);

import 'dart:convert';

List<CenterSelectedDWardModel> centerSelectedDWardModelFromJson(String str) => List<CenterSelectedDWardModel>.from(json.decode(str).map((x) => CenterSelectedDWardModel.fromJson(x)));

String centerSelectedDWardModelToJson(List<CenterSelectedDWardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CenterSelectedDWardModel {
  String wardId;
  String wardName;
  int totalDoctor;

  CenterSelectedDWardModel({
    required this.wardId,
    required this.wardName,
    required this.totalDoctor,
  });

  factory CenterSelectedDWardModel.fromJson(Map<String, dynamic> json) => CenterSelectedDWardModel(
    wardId: json["ward_id"],
    wardName: json["ward_name"],
    totalDoctor: json["total_doctor"],
  );

  Map<String, dynamic> toJson() => {
    "ward_id": wardId,
    "ward_name": wardName,
    "total_doctor": totalDoctor,
  };
}
