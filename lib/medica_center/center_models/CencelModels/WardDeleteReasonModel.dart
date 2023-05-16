// To parse this JSON data, do
//
//     final wardDeleteReasonModel = wardDeleteReasonModelFromJson(jsonString);

import 'dart:convert';

List<WardDeleteReasonModel> wardDeleteReasonModelFromJson(String str) => List<WardDeleteReasonModel>.from(json.decode(str).map((x) => WardDeleteReasonModel.fromJson(x)));

String wardDeleteReasonModelToJson(List<WardDeleteReasonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WardDeleteReasonModel {
  String id;
  String reason;

  WardDeleteReasonModel({
    required this.id,
    required this.reason,
  });

  factory WardDeleteReasonModel.fromJson(Map<String, dynamic> json) => WardDeleteReasonModel(
    id: json["id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  };
}
