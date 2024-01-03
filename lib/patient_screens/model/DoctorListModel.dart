// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorListModel> doctorListModelFromJson(String str) => List<DoctorListModel>.from(json.decode(str).map((x) => DoctorListModel.fromJson(x)));

String doctorListModelToJson(List<DoctorListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorListModel {
  String result;
  String rating;
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
  String doctorDocument;

  DoctorListModel({
    required this.result,
    required this.rating,
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
    required this.doctorDocument,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) => DoctorListModel(
    result: json["result"].toString(),
    rating: json["rating"].toString(),
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
    doctorDocument: json["Doctor_document"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "rating": rating,
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
    "Doctor_document": doctorDocument,
  };
}
