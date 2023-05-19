// To parse this JSON data, do
//
//     final pCenterListModel = pCenterListModelFromJson(jsonString);

import 'dart:convert';

List<PCenterListModel> pCenterListModelFromJson(String str) => List<PCenterListModel>.from(json.decode(str).map((x) => PCenterListModel.fromJson(x)));

String pCenterListModelToJson(List<PCenterListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PCenterListModel {
  String result;
  String centerId;
  String name;
  String email;
  String address;
  String latitude;
  String longitude;
  String password;
  String biography;
  String image;

  PCenterListModel({
    required this.result,
    required this.centerId,
    required this.name,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.password,
    required this.biography,
    required this.image,
  });

  factory PCenterListModel.fromJson(Map<String, dynamic> json) => PCenterListModel(
    result: json["result"],
    centerId: json["center_id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    password: json["password"],
    biography: json["biography"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "center_id": centerId,
    "name": name,
    "email": email,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "password": password,
    "biography": biography,
    "image": image,
  };
}
