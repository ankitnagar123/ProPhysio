// To parse this JSON data, do
//
//     final doctorbookedSlotList = doctorbookedSlotListFromJson(jsonString);

import 'dart:convert';

List<DoctorbookedSlotList> doctorbookedSlotListFromJson(String str) => List<DoctorbookedSlotList>.from(json.decode(str).map((x) => DoctorbookedSlotList.fromJson(x)));

String doctorbookedSlotListToJson(List<DoctorbookedSlotList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorbookedSlotList {
  String timeId;
  String from;
  String to;

  DoctorbookedSlotList({
    required this.timeId,
    required this.from,
    required this.to,
  });

  factory DoctorbookedSlotList.fromJson(Map<String, dynamic> json) => DoctorbookedSlotList(
    timeId: json["time_id"],
    from: json["From"],
    to: json["To"],
  );

  Map<String, dynamic> toJson() => {
    "time_id": timeId,
    "From": from,
    "To": to,
  };
}
