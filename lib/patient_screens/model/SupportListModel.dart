// To parse this JSON data, do
//
//     final supportListModel = supportListModelFromJson(jsonString);

import 'dart:convert';

List<SupportListModel> supportListModelFromJson(String str) => List<SupportListModel>.from(json.decode(str).map((x) => SupportListModel.fromJson(x)));

String supportListModelToJson(List<SupportListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportListModel {
  String userId;
  String subject;
  String email;
  String message;
  String staffName;
  String supportStatus;

  SupportListModel({
    required this.userId,
    required this.subject,
    required this.email,
    required this.message,
    required this.staffName,
    required this.supportStatus,
  });

  factory SupportListModel.fromJson(Map<String, dynamic> json) => SupportListModel(
    userId: json["user_id"],
    subject: json["subject"],
    email: json["email"],
    message: json["message"],
    staffName: json["staff_name"],
    supportStatus: json["support_status"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "subject": subject,
    "email": email,
    "message": message,
    "staff_name": staffName,
    "support_status": supportStatus,
  };
}
