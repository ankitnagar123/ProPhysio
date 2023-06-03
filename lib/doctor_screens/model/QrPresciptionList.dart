// To parse this JSON data, do
//
//     final prescriptionReportQrModel = prescriptionReportQrModelFromJson(jsonString);

import 'dart:convert';

PrescriptionReportQrModel prescriptionReportQrModelFromJson(String str) => PrescriptionReportQrModel.fromJson(json.decode(str));

String prescriptionReportQrModelToJson(PrescriptionReportQrModel data) => json.encode(data.toJson());

class PrescriptionReportQrModel {
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

  PrescriptionReportQrModel({
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

  factory PrescriptionReportQrModel.fromJson(Map<String, dynamic> json) => PrescriptionReportQrModel(
    userId: json["user_id"],
    name: json["name"],
    surname: json["surname"],
    username: json["username"],
    email: json["email"],
    healthCard: json["health_card"],
    location: json["location"],
    enGender: json["en_gender"],
    code: json["code"],
    contact: json["contact"],
    age: json["age"],
    weight: json["weight"],
    height: json["height"],
    birthPlace: json["birth_place"],
    taxCode: json["tax_code"],
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
  String doctorId;
  String doctorName;
  String doctorSurname;
  String title;
  String type;
  String description;
  String image;

  Detail({
    required this.result,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSurname,
    required this.title,
    required this.type,
    required this.description,
    required this.image,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    result: json["result"],
    doctorId: json["doctor_id"],
    doctorName: json["doctor_name"],
    doctorSurname: json["doctor_surname"],
    title: json["title"],
    type: json["type"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "doctor_id": doctorId,
    "doctor_name": doctorName,
    "doctor_surname": doctorSurname,
    "title": title,
    "type": type,
    "description": description,
    "image": image,
  };
}
