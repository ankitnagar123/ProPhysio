// To parse this JSON data, do
//
//     final doctorListModel = doctorListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorListModel> doctorListModelFromJson(String str) => List<DoctorListModel>.from(json.decode(str).map((x) => DoctorListModel.fromJson(x)));

String doctorListModelToJson(List<DoctorListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorListModel {
  String branch;
  String result;
  String fees;
  String rating;
  String distance;
  String userId;
  String doctorId;
  String serviceStatus;
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
  List<String?> category;
  List<String?> subcategory;
  String doctorProfile;
  String doctorDocument;

  DoctorListModel({
    required this.branch,
    required this.result,
    required this.fees,
    required this.rating,
    required this.distance,
    required this.userId,
    required this.doctorId,
    required this.serviceStatus,
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

  factory DoctorListModel.fromJson(Map<String, dynamic> json) => DoctorListModel(
    branch: json["branch"].toString(),
    result:json["result"].toString(),
    fees: json["fees"].toString(),
    rating: json["rating"].toString(),
    distance: json["distance"].toString(),
    userId: json["user_id"].toString(),
    doctorId: json["doctor_id"].toString(),
    serviceStatus:json["service_status"].toString(),
    name: json["name"].toString(),
    surname: json["surname"].toString(),
    username: json["username"].toString(),
    email: json["email"].toString(),
    code: json["code"].toString(),
    contact: json["contact"].toString(),
    location: json["location"].toString(),
    latitude: json["latitude"].toString(),
    longitude: json["longitude"].toString(),
    password: json["password"].toString(),
    category: List<String?>.from(json["category"].map((x) => x)),
    subcategory: List<String?>.from(json["subcategory"].map((x) => x)),
    doctorProfile: json["Doctor_profile"].toString(),
    doctorDocument: json["Doctor_document"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "branch": branch,
    "result": result,
    "fees": fees,
    "rating": rating,
    "distance": distance,
    "user_id": userId,
    "doctor_id": doctorId,
    "service_status":serviceStatus,
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

enum Result {
  SUCCESS
}

final resultValues = EnumValues({
  "Success": Result.SUCCESS
});

enum ServiceStatus {
  EMPTY,
  FREE
}

final serviceStatusValues = EnumValues({
  "": ServiceStatus.EMPTY,
  "Free": ServiceStatus.FREE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
