// To parse this JSON data, do
//
//     final patinetChatModel = patinetChatModelFromJson(jsonString);

import 'dart:convert';

List<PatinetChatModel> patinetChatModelFromJson(String str) => List<PatinetChatModel>.from(json.decode(str).map((x) => PatinetChatModel.fromJson(x)));

String patinetChatModelToJson(List<PatinetChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatinetChatModel {
  PatinetChatModel({
    required this.doctorId,
    required this.time,
    required this.name,
    required this.surname,
    required this.username,
    required this.userProfile,
  });

  String doctorId;
  String time;
  String name;
  String surname;
  String username;
  String userProfile;

  factory PatinetChatModel.fromJson(Map<String, dynamic> json) => PatinetChatModel(
    doctorId: json["doctor_id"],
    time: json["time"],
    name: json["name"],
    surname: json["surname"],
    username: json["username"],
    userProfile: json["user_profile"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "time": time,
    "name": name,
    "surname": surname,
    "username": username,
    "user_profile": userProfile,
  };
}
