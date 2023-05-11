// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorListModel> doctorListModelFromJson(String str) => List<DoctorListModel>.from(json.decode(str).map((x) => DoctorListModel.fromJson(x)));

String doctorListModelToJson(List<DoctorListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorListModel {
  DoctorListModel({
    required this.result,
    required this.fees,
    required this.rating,
    required this.distance,
    required this.doctorId,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.code,
    required this.contact,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.password,
    required this.category,
    required this.subcategory,
    required this.doctorProfile,
    required this.doctorDocument,
  });

  String result;
  String fees;
  String rating;
  int distance;
  String doctorId;
  String name;
  String surname;
  String username;
  String email;
  String code;
  String contact;
  String location;
  String latitude;
  String longitude;
  String password;
  List<String> category;
  List<String> subcategory;
  String doctorProfile;
  String doctorDocument;

  factory DoctorListModel.fromJson(Map<String, dynamic> json) => DoctorListModel(
    result: json["result"],
    fees: json["fees"],
    rating: json["rating"],
    distance: json["distance"],
    doctorId: json["doctor_id"],
    name: json["name"],
    surname: json["surname"],
    username: json["username"],
    email: json["email"],
    code: json["code"],
    contact: json["contact"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    password: json["password"],
    category: List<String>.from(json["category"].map((x) => x)),
    subcategory: List<String>.from(json["subcategory"].map((x) => x)),
    doctorProfile: json["Doctor_profile"],
    doctorDocument: json["Doctor_document"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "fees": fees,
    "rating": rating,
    "distance": distance,
    "doctor_id": doctorId,
    "name": name,
    "surname": surname,
    "username": username,
    "email": email,
    "code": code,
    "contact": contact,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "password": password,
    "category": List<dynamic>.from(category.map((x) => x)),
    "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
    "Doctor_profile": doctorProfile,
    "Doctor_document": doctorDocument,
  };
}
