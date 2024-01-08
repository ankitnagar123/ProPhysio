// To parse this JSON data, do
//
//     final learningManageTypeModel = learningManageTypeModelFromJson(jsonString);

import 'dart:convert';

List<LearningManageTypeModel> learningManageTypeModelFromJson(String str) => List<LearningManageTypeModel>.from(json.decode(str).map((x) => LearningManageTypeModel.fromJson(x)));

String learningManageTypeModelToJson(List<LearningManageTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LearningManageTypeModel {
  String learningName;
  String learningType;

  LearningManageTypeModel({
    required this.learningName,
    required this.learningType,
  });

  factory LearningManageTypeModel.fromJson(Map<String, dynamic> json) => LearningManageTypeModel(
    learningName: json["learning_name"],
    learningType: json["learning_type"],
  );

  Map<String, dynamic> toJson() => {
    "learning_name": learningName,
    "learning_type": learningType,
  };
}
