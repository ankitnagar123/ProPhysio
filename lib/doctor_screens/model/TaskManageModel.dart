// To parse this JSON data, do
//
//     final taskManageListModel = taskManageListModelFromJson(jsonString);

import 'dart:convert';

List<TaskManageListModel> taskManageListModelFromJson(String str) => List<TaskManageListModel>.from(json.decode(str).map((x) => TaskManageListModel.fromJson(x)));

String taskManageListModelToJson(List<TaskManageListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskManageListModel {
  String allotId;
  String taskId;
  String taskName;
  String taskDescription;
  String date;
  String time;
  String status;

  TaskManageListModel({
    required this.allotId,
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.date,
    required this.time,
    required this.status,
  });

  factory TaskManageListModel.fromJson(Map<String, dynamic> json) => TaskManageListModel(
    allotId: json["allot_id"],
    taskId: json["task_id"],
    taskName: json["task_name"],
    taskDescription: json["task_description"],
    date:json["date"],
    time: json["time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "allot_id": allotId,
    "task_id": taskId,
    "task_name": taskName,
    "task_description": taskDescription,
    "date": date,
    "time": time,
    "status": status,
  };
}
