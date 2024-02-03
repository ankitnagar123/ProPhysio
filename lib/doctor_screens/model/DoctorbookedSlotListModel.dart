// To parse this JSON data, do
//
//     final doctorbookedSlotList = doctorbookedSlotListFromJson(jsonString);

import 'dart:convert';

List<DoctorbookedSlotList> doctorbookedSlotListFromJson(String str) => List<DoctorbookedSlotList>.from(json.decode(str).map((x) => DoctorbookedSlotList.fromJson(x)));

String doctorbookedSlotListToJson(List<DoctorbookedSlotList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorbookedSlotList {
  String From;
  String To;

  DoctorbookedSlotList({
    required this.From,
    required this.To,
  });

  factory DoctorbookedSlotList.fromJson(Map<String, dynamic> json) => DoctorbookedSlotList(
    From: json["From"],
    To: json["To"],
  );

  Map<String, dynamic> toJson() => {
    "From": From,
    "To": To,
  };
}
