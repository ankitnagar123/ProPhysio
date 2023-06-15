// To parse this JSON data, do
//
//     final centerRequestListModel = centerRequestListModelFromJson(jsonString);

import 'dart:convert';

List<CenterRequestListModel> centerRequestListModelFromJson(String str) => List<CenterRequestListModel>.from(json.decode(str).map((x) => CenterRequestListModel.fromJson(x)));

String centerRequestListModelToJson(List<CenterRequestListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CenterRequestListModel {
  String wardId;
  String wardName;
  String centerId;
  String centerName;
  String centerEmail;
  String address;
  String biography;
  String image;

  CenterRequestListModel({
    required this.wardId,
    required this.wardName,
    required this.centerId,
    required this.centerName,
    required this.centerEmail,
    required this.address,
    required this.biography,
    required this.image,
  });

  factory CenterRequestListModel.fromJson(Map<String, dynamic> json) => CenterRequestListModel(
    wardId: json["ward_id"],
    wardName: json["ward_name"],
    centerId: json["center_id"],
    centerName: json["center_name"],
    centerEmail: json["center_email"],
    address: json["address"],
    biography: json["biography"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "ward_id": wardId,
    "ward_name": wardName,
    "center_id": centerId,
    "center_name": centerName,
    "center_email": centerEmail,
    "address": address,
    "biography": biography,
    "image": image,
  };
}
