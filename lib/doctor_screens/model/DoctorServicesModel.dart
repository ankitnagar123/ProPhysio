// To parse this JSON data, do
//
//     final doctorServicesModel = doctorServicesModelFromJson(jsonString);

import 'dart:convert';

List<DoctorServicesModel> doctorServicesModelFromJson(String str) => List<DoctorServicesModel>.from(json.decode(str).map((x) => DoctorServicesModel.fromJson(x)));

String doctorServicesModelToJson(List<DoctorServicesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorServicesModel {
  String serviceId;
  String serviceName;

  DoctorServicesModel({
    required this.serviceId,
    required this.serviceName,
  });

  factory DoctorServicesModel.fromJson(Map<String, dynamic> json) => DoctorServicesModel(
    serviceId: json["service_id"].toString(),
    serviceName: json["service_name"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "service_name": serviceName,
  };
}
