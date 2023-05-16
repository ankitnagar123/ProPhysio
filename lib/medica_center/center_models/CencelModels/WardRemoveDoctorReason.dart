// To parse this JSON data, do
//
//     final wardRemoveDoctorReason = wardRemoveDoctorReasonFromJson(jsonString);

import 'dart:convert';

List<WardRemoveDoctorReason> wardRemoveDoctorReasonFromJson(String str) => List<WardRemoveDoctorReason>.from(json.decode(str).map((x) => WardRemoveDoctorReason.fromJson(x)));

String wardRemoveDoctorReasonToJson(List<WardRemoveDoctorReason> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WardRemoveDoctorReason {
  String id;
  String reason;

  WardRemoveDoctorReason({
    required this.id,
    required this.reason,
  });

  factory WardRemoveDoctorReason.fromJson(Map<String, dynamic> json) => WardRemoveDoctorReason(
    id: json["id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reason": reason,
  };
}
