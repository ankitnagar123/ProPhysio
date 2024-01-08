// To parse this JSON data, do
//
//     final learningManageListModel = learningManageListModelFromJson(jsonString);

import 'dart:convert';

List<LearningManageListModel> learningManageListModelFromJson(String str) => List<LearningManageListModel>.from(json.decode(str).map((x) => LearningManageListModel.fromJson(x)));

String learningManageListModelToJson(List<LearningManageListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LearningManageListModel {
  String trainingId;
  String title;
  String date;
  String bannerImg;

  LearningManageListModel({
    required this.trainingId,
    required this.title,
    required this.date,
    required this.bannerImg,
  });

  factory LearningManageListModel.fromJson(Map<String, dynamic> json) => LearningManageListModel(
    trainingId: json["training_id"].toString(),
    title: json["title"].toString(),
    date: json["date"].toString(),
    bannerImg: json["banner_img"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "training_id": trainingId,
    "title": title,
    "date": date,
    "banner_img": bannerImg,
  };
}
