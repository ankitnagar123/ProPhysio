/*
// To parse this JSON data, do
//
//     final dPrescriptionListModel = dPrescriptionListModelFromJson(jsonString);

import 'dart:convert';

DPrescriptionListModel dPrescriptionListModelFromJson(String str) => DPrescriptionListModel.fromJson(json.decode(str));

String dPrescriptionListModelToJson(DPrescriptionListModel data) => json.encode(data.toJson());

class DPrescriptionListModel {
  String userId;
  String name;
  String surname;
  String username;
  String email;
  String healthCard;
  String location;
  String enGender;
  String code;
  String contact;
  String age;
  String weight;
  String height;
  String birthPlace;
  String taxCode;
  List<Detail> details;

  DPrescriptionListModel({
    required this.userId,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.healthCard,
    required this.location,
    required this.enGender,
    required this.code,
    required this.contact,
    required this.age,
    required this.weight,
    required this.height,
    required this.birthPlace,
    required this.taxCode,
    required this.details,
  });

  factory DPrescriptionListModel.fromJson(Map<String, dynamic> json) => DPrescriptionListModel(
    userId: json["user_id"].toString(),
    name: json["name"].toString(),
    surname: json["surname"].toString(),
    username: json["username"].toString(),
    email: json["email"].toString(),
    healthCard: json["health_card"].toString(),
    location: json["location"].toString(),
    enGender: json["en_gender"].toString(),
    code: json["code"].toString(),
    contact: json["contact"].toString(),
    age: json["age"].toString(),
    weight: json["weight"].toString(),
    height: json["height"].toString(),
    birthPlace: json["birth_place"].toString(),
    taxCode: json["tax_code"].toString(),
    details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "surname": surname,
    "username": username,
    "email": email,
    "health_card": healthCard,
    "location": location,
    "en_gender": enGender,
    "code": code,
    "contact": contact,
    "age": age,
    "weight": weight,
    "height": height,
    "birth_place": birthPlace,
    "tax_code": taxCode,
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  String result;
  String title;
  String type;
  String description;
  String image;
  String? doctorId;
  String? doctorName;
  String? doctorSurname;

  Detail({
    required this.result,
    required this.title,
    required this.type,
    required this.description,
    required this.image,
    this.doctorId,
    this.doctorName,
    this.doctorSurname,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    result: json["result"],
    title: json["title"],
    type: json["type"],
    description: json["description"],
    image: json["image"],
    doctorId: json["doctor_id"],
    doctorName: json["doctor_name"],
    doctorSurname: json["doctor_surname"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "title": title,
    "type": type,
    "description": description,
    "image": image,
    "doctor_id": doctorId,
    "doctor_name": doctorName,
    "doctor_surname": doctorSurname,
  };
}
*/
// To parse this JSON data, do
//
//     final dPrescriptionListModel = dPrescriptionListModelFromJson(jsonString);

import 'dart:convert';

DPrescriptionListModel dPrescriptionListModelFromJson(String str) => DPrescriptionListModel.fromJson(json.decode(str));

String dPrescriptionListModelToJson(DPrescriptionListModel data) => json.encode(data.toJson());

class DPrescriptionListModel {
  String userId;
  String name;
  String surname;
  String username;
  String email;
  String healthCard;
  String location;
  String enGender;
  String code;
  String contact;
  String age;
  String weight;
  String height;
  String birthPlace;
  String taxCode;
  List<Detail> details;

  DPrescriptionListModel({
    required this.userId,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.healthCard,
    required this.location,
    required this.enGender,
    required this.code,
    required this.contact,
    required this.age,
    required this.weight,
    required this.height,
    required this.birthPlace,
    required this.taxCode,
    required this.details,
  });

  factory DPrescriptionListModel.fromJson(Map<String, dynamic> json) => DPrescriptionListModel(
    userId: json["user_id"].toString(),
    name: json["name"].toString(),
    surname: json["surname"].toString(),
    username: json["username"].toString(),
    email: json["email"].toString(),
    healthCard: json["health_card"].toString(),
    location: json["location"].toString(),
    enGender: json["en_gender"].toString(),
    code: json["code"].toString(),
    contact: json["contact"].toString(),
    age: json["age"].toString(),
    weight: json["weight"].toString(),
    height: json["height"].toString(),
    birthPlace: json["birth_place"].toString(),
    taxCode: json["tax_code"].toString(),
    details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "surname": surname,
    "username": username,
    "email": email,
    "health_card": healthCard,
    "location": location,
    "en_gender": enGender,
    "code": code,
    "contact": contact,
    "age": age,
    "weight": weight,
    "height": height,
    "birth_place": birthPlace,
    "tax_code": taxCode,
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  String result;
  String title;
  String type;
  String description;
  String image;
  String? doctorId;
  String? doctorName;
  String? doctorSurname;

  Detail({
    required this.result,
    required this.title,
    required this.type,
    required this.description,
    required this.image,
    this.doctorId,
    this.doctorName,
    this.doctorSurname,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    result: json["result"].toString(),
    title: json["title"].toString(),
    type: json["type"].toString(),
    description: json["description"].toString(),
    image: json["image"].toString(),
    doctorId: json["doctor_id"].toString(),
    doctorName: json["doctor_name"].toString(),
    doctorSurname: json["doctor_surname"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "title": title,
    "type": type,
    "description": description,
    "image": image,
    "doctor_id": doctorId,
    "doctor_name": doctorName,
    "doctor_surname": doctorSurname,
  };
}
