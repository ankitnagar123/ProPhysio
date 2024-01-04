// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorListModel> doctorListModelFromJson(String str) => List<DoctorListModel>.from(json.decode(str).map((x) => DoctorListModel.fromJson(x)));

String doctorListModelToJson(List<DoctorListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorListModel {
  String result;
  String rating;
  String branchId;
  String branchName;
  String branchAddress;
  String branchLat;
  String branchLong;
  String userId;
  String doctorId;
  String name;
  String surname;
  String username;
  String location;
  String latitude;
  String longitude;
  String category;
  String doctorProfile;

  DoctorListModel({
    required this.result,
    required this.rating,
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchLat,
    required this.branchLong,
    required this.userId,
    required this.doctorId,
    required this.name,
    required this.surname,
    required this.username,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.doctorProfile,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) => DoctorListModel(
    result: json["result"].toString(),
    rating: json["rating"].toString(),
    branchId: json["branch_id"].toString(),
    branchName: json["branch_name"].toString(),
    branchAddress: json["branch_address"].toString(),
    branchLat: json["branch_lat"].toString(),
    branchLong: json["branch_long"].toString(),
    userId: json["user_id"].toString(),
    doctorId: json["doctor_id"].toString(),
    name: json["name"].toString(),
    surname: json["surname"].toString(),
    username: json["username"].toString(),
    location: json["location"].toString(),
    latitude: json["latitude"].toString(),
    longitude: json["longitude"].toString(),
    category: json["category"].toString(),
    doctorProfile: json["Doctor_profile"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "rating": rating,
    "branch_id": branchId,
    "branch_name": branchName,
    "branch_address": branchAddress,
    "branch_lat": branchLat,
    "branch_long": branchLong,
    "user_id": userId,
    "doctor_id": doctorId,
    "name": name,
    "surname": surname,
    "username": username,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "category": category,
    "Doctor_profile": doctorProfile,
  };
}
