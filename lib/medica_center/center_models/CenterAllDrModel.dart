// To parse this JSON data, do
//
//     final centerDoctorListModel = centerDoctorListModelFromJson(jsonString);

import 'dart:convert';

List<CenterDoctorListModel> centerDoctorListModelFromJson(String str) => List<CenterDoctorListModel>.from(json.decode(str).map((x) => CenterDoctorListModel.fromJson(x)));

String centerDoctorListModelToJson(List<CenterDoctorListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CenterDoctorListModel {
  Result result;
  String fees;
  String rating;
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
  dynamic category;
  dynamic subcategory;
  String doctorProfile;
  String doctorDocument;

  CenterDoctorListModel({
    required this.result,
    required this.fees,
    required this.rating,
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

  factory CenterDoctorListModel.fromJson(Map<String, dynamic> json) => CenterDoctorListModel(
    result: resultValues.map[json["result"]]!,
    fees: json["fees"],
    rating: json["rating"],
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
    category: json["category"],
    subcategory: json["subcategory"],
    doctorProfile: json["Doctor_profile"],
    doctorDocument: json["Doctor_document"],
  );

  Map<String, dynamic> toJson() => {
    "result": resultValues.reverse[result],
    "fees": fees,
    "rating": rating,
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
    "category": category,
    "subcategory": subcategory,
    "Doctor_profile": doctorProfile,
    "Doctor_document": doctorDocument,
  };
}

enum Code { THE_91, THE_39, EMPTY, THE_919977112912 }

final codeValues = EnumValues({
  "": Code.EMPTY,
  "+39": Code.THE_39,
  "+91": Code.THE_91,
  "+919977112912": Code.THE_919977112912
});

enum Result { SUCCESS }

final resultValues = EnumValues({
  "Success": Result.SUCCESS
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
