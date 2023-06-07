// To parse this JSON data, do
//
//     final centerAddMoreDrModel = centerAddMoreDrModelFromJson(jsonString);

import 'dart:convert';

List<CenterAddMoreDrModel> centerAddMoreDrModelFromJson(String str) => List<CenterAddMoreDrModel>.from(json.decode(str).map((x) => CenterAddMoreDrModel.fromJson(x)));

String centerAddMoreDrModelToJson(List<CenterAddMoreDrModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CenterAddMoreDrModel {
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
  List<Category> category;
  List<Subcategory> subcategory;
  String doctorProfile;
  String doctorDocument;

  CenterAddMoreDrModel({
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

  factory CenterAddMoreDrModel.fromJson(Map<String, dynamic> json) => CenterAddMoreDrModel(
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
    category: List<Category>.from(json["category"].map((x) => categoryValues.map[x]!)),
    subcategory: List<Subcategory>.from(json["subcategory"].map((x) => subcategoryValues.map[x]!)),
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
    "category": List<dynamic>.from(category.map((x) => categoryValues.reverse[x])),
    "subcategory": List<dynamic>.from(subcategory.map((x) => subcategoryValues.reverse[x])),
    "Doctor_profile": doctorProfile,
    "Doctor_document": doctorDocument,
  };
}

enum Category { DENTIST }

final categoryValues = EnumValues({
  "Dentist": Category.DENTIST
});

enum Result { SUCCESS }

final resultValues = EnumValues({
  "Success": Result.SUCCESS
});

enum Subcategory { CHILD_DENTIST }

final subcategoryValues = EnumValues({
  "Child Dentist": Subcategory.CHILD_DENTIST
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
