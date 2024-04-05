// To parse this JSON data, do
//
//     final leadSheetModel = leadSheetModelFromJson(jsonString);

import 'dart:convert';

List<LeadSheetModel> leadSheetModelFromJson(String str) => List<LeadSheetModel>.from(json.decode(str).map((x) => LeadSheetModel.fromJson(x)));

String leadSheetModelToJson(List<LeadSheetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeadSheetModel {
  String leadId;
  String name;
  String email;
  String contact;
  String source;
  String task;
  String notes;
  String createdAt;
  String status;

  LeadSheetModel({
    required this.leadId,
    required this.name,
    required this.email,
    required this.contact,
    required this.source,
    required this.task,
    required this.notes,
    required this.createdAt,
    required this.status,
  });

  factory LeadSheetModel.fromJson(Map<String, dynamic> json) => LeadSheetModel(
    leadId: json["lead_id"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    source: json["source"],
    task: json["task"],
    notes: json["notes"],
    createdAt:json["created_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "lead_id": leadId,
    "name": name,
    "email": email,
    "contact": contact,
    "source": source,
    "task": task,
    "notes": notes,
    "created_at": createdAt,
    "status": status,
  };
}
