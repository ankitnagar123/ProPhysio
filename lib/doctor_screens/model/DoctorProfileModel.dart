// To parse this JSON data, do
//
//     final doctorProfileModel = doctorProfileModelFromJson(jsonString);

import 'dart:convert';

DoctorProfileModel doctorProfileModelFromJson(String str) => DoctorProfileModel.fromJson(json.decode(str));

String doctorProfileModelToJson(DoctorProfileModel data) => json.encode(data.toJson());

class DoctorProfileModel {
  String result;
  String id;
  String name;
  String surname;
  String username;
  String email;
  String flag;
  String code;
  String contact;
  String gender;
  String location;
  String latitude;
  String longitude;
  String biography;
  String birthDate;
  String birthPlace;
  String password;
  String age;
  String experience;
  String description;
  String branchId;
  String branchName;
  String categoryId;
  String categoryName;
  String doctorProfile;
  String doctorDocument;
  List<Service> service;
  List<TotalDay> totalDay;
  String startTime;
  String endTime;

  DoctorProfileModel({
    required this.result,
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.flag,
    required this.code,
    required this.contact,
    required this.gender,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.biography,
    required this.birthDate,
    required this.birthPlace,
    required this.password,
    required this.age,
    required this.experience,
    required this.description,
    required this.branchId,
    required this.branchName,
    required this.categoryId,
    required this.categoryName,
    required this.doctorProfile,
    required this.doctorDocument,
    required this.service,
    required this.totalDay,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) => DoctorProfileModel(
    result: json["result"].toString(),
    id: json["id"].toString(),
    name: json["name"].toString(),
    surname: json["surname"].toString(),
    username: json["username"].toString(),
    email: json["email"].toString(),
    flag: json["flag"].toString(),
    code: json["code"].toString(),
    contact: json["contact"].toString(),
    gender: json["gender"].toString(),
    location: json["location"].toString(),
    latitude: json["latitude"].toString(),
    longitude: json["longitude"].toString(),
    biography: json["biography"].toString(),
    birthDate: json["birth_date"].toString(),
    birthPlace: json["birth_place"].toString(),
    password: json["password"].toString(),
    age: json["age"].toString(),
    experience: json["experience"].toString(),
    description: json["description"].toString(),
    branchId: json["branch_id"].toString(),
    branchName: json["branch_name"].toString(),
    categoryId: json["category_id"].toString(),
    categoryName: json["category_name"].toString(),
    doctorProfile: json["Doctor_profile"].toString(),
    doctorDocument: json["Doctor_document"].toString(),
    service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
    totalDay: List<TotalDay>.from(json["total_day"].map((x) => TotalDay.fromJson(x))),
    startTime: json["start_time"].toString(),
    endTime: json["end_time"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "id": id,
    "name": name,
    "surname": surname,
    "username": username,
    "email": email,
    "flag": flag,
    "code": code,
    "contact": contact,
    "gender": gender,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "biography": biography,
    "birth_date": birthDate,
    "birth_place": birthPlace,
    "password": password,
    "age": age,
    "experience": experience,
    "description": description,
    "branch_id": branchId,
    "branch_name": branchName,
    "category_id": categoryId,
    "category_name": categoryName,
    "Doctor_profile": doctorProfile,
    "Doctor_document": doctorDocument,
    "service": List<dynamic>.from(service.map((x) => x.toJson())),
    "total_day": List<dynamic>.from(totalDay.map((x) => x.toJson())),
    "start_time": startTime,
    "end_time": endTime,
  };
}

class Service {
  String naam;
  String id;

  Service({
    required this.naam,
    required this.id,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    naam: json["naam"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "naam": naam,
    "id": id,
  };
}

class TotalDay {
  String day;

  TotalDay({
    required this.day,
  });

  factory TotalDay.fromJson(Map<String, dynamic> json) => TotalDay(
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
  };
}
