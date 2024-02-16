// To parse this JSON data, do
//
//     final taskCancelListModel = taskCancelListModelFromJson(jsonString);

import 'dart:convert';

List<TaskCancelListModel> taskCancelListModelFromJson(String str) => List<TaskCancelListModel>.from(json.decode(str).map((x) => TaskCancelListModel.fromJson(x)));

String taskCancelListModelToJson(List<TaskCancelListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskCancelListModel {
  String id;
  String reason;

  TaskCancelListModel({
    required this.id,
    required this.reason,
  });

  factory TaskCancelListModel.fromJson(Map<String, dynamic> json) => TaskCancelListModel(
    id: json["id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  };
}
