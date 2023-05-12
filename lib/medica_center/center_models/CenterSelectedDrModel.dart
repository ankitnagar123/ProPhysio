// To parse this JSON data, do
//
//     final centerSelectedDListModel = centerSelectedDListModelFromJson(jsonString);

import 'dart:convert';

CenterSelectedDListModel centerSelectedDListModelFromJson(String str) => CenterSelectedDListModel.fromJson(json.decode(str));

String centerSelectedDListModelToJson(CenterSelectedDListModel data) => json.encode(data.toJson());

class CenterSelectedDListModel {
  String result;
  String medicalCenterName;
  List<DoctorList> doctorList;

  CenterSelectedDListModel({
    required this.result,
    required this.medicalCenterName,
    required this.doctorList,
  });

  factory CenterSelectedDListModel.fromJson(Map<String, dynamic> json) => CenterSelectedDListModel(
    result: json["result"],
    medicalCenterName: json["medical_center_name"],
    doctorList: List<DoctorList>.from(json["doctor_list"].map((x) => DoctorList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "medical_center_name": medicalCenterName,
    "doctor_list": List<dynamic>.from(doctorList.map((x) => x.toJson())),
  };
}

class DoctorList {
  String doctorId;
  String name;
  String surname;
  String username;
  String email;
  String gender;
  String code;
  String contact;
  String location;
  String latitude;
  String longitude;
  String biography;
  String birthDate;
  String birthPlace;
  String universityAttended;
  String enrollmentDate;
  String registerOfBelonging;
  String graduationDate;
  String qualificationDate;
  String password;
  String doctorProfile;
  String doctorDocument;
  List<Cat> cat;

  DoctorList({
    required this.doctorId,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.gender,
    required this.code,
    required this.contact,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.biography,
    required this.birthDate,
    required this.birthPlace,
    required this.universityAttended,
    required this.enrollmentDate,
    required this.registerOfBelonging,
    required this.graduationDate,
    required this.qualificationDate,
    required this.password,
    required this.doctorProfile,
    required this.doctorDocument,
    required this.cat,
  });

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
    doctorId: json["doctor_id"],
    name: json["name"],
    surname: json["surname"],
    username: json["username"],
    email: json["email"],
    gender: json["gender"],
    code: json["code"],
    contact: json["contact"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    biography: json["biography"],
    birthDate: json["birth_date"],
    birthPlace: json["birth_place"],
    universityAttended: json["university_attended"],
    enrollmentDate: json["enrollment_date"],
    registerOfBelonging: json["register_of_belonging"],
    graduationDate: json["graduation_date"],
    qualificationDate: json["qualification_date"],
    password: json["password"],
    doctorProfile: json["Doctor_profile"],
    doctorDocument: json["Doctor_document"],
    cat: List<Cat>.from(json["cat"].map((x) => Cat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "name": name,
    "surname": surname,
    "username": username,
    "email": email,
    "gender": gender,
    "code": code,
    "contact": contact,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "biography": biography,
    "birth_date": birthDate,
    "birth_place": birthPlace,
    "university_attended": universityAttended,
    "enrollment_date": enrollmentDate,
    "register_of_belonging": registerOfBelonging,
    "graduation_date": graduationDate,
    "qualification_date": qualificationDate,
    "password": password,
    "Doctor_profile": doctorProfile,
    "Doctor_document": doctorDocument,
    "cat": List<dynamic>.from(cat.map((x) => x.toJson())),
  };
}

class Cat {
  String categoryId;
  String categoryName;
  String subcategoryName;

  Cat({
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryName,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    subcategoryName: json["subcategory_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "subcategory_name": subcategoryName,
  };
}
