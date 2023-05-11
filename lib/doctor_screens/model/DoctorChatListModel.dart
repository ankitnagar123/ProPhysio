// To parse this JSON data, do
//
//     final doctorChatModel = doctorChatModelFromJson(jsonString);

import 'dart:convert';

List<DoctorChatModel> doctorChatModelFromJson(String str) => List<DoctorChatModel>.from(json.decode(str).map((x) => DoctorChatModel.fromJson(x)));

String doctorChatModelToJson(List<DoctorChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorChatModel {
  DoctorChatModel({
    required this.userId,
    required this.time,
    required this.name,
    required this.surname,
    required this.username,
    required this.userProfile,
  });

  String userId;
  String time;
  String name;
  String surname;
  String username;
  String userProfile;

  factory DoctorChatModel.fromJson(Map<String, dynamic> json) => DoctorChatModel(
    userId: json["user_id"],
    time: json["time"],
    name: json["name"],
    surname: json["surname"],
    username: json["username"],
    userProfile: json["user_profile"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "time": time,
    "name": name,
    "surname": surname,
    "username": username,
    "user_profile": userProfile,
  };
}
