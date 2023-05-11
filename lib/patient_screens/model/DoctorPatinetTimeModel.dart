/*
// To parse this JSON data, do
//
//     final doctorPatinetTimeListModel = doctorPatinetTimeListModelFromJson(jsonString);

import 'dart:convert';

List<DoctorPatinetTimeListModel> doctorPatinetTimeListModelFromJson(String str) => List<DoctorPatinetTimeListModel>.from(json.decode(str).map((x) => DoctorPatinetTimeListModel.fromJson(x)));

String doctorPatinetTimeListModelToJson(List<DoctorPatinetTimeListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorPatinetTimeListModel {
  DoctorPatinetTimeListModel({
    required this.timeId,
    required this.from,
    required this.to,
  });

  String timeId;
  String from;
  String to;

  factory DoctorPatinetTimeListModel.fromJson(Map<String, dynamic> json) => DoctorPatinetTimeListModel(
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
*/
class DoctorTimeListModelpatinet {
  String? timeId;
  String? from;
  String? to;

  DoctorTimeListModelpatinet({this.timeId, this.from, this.to});

  DoctorTimeListModelpatinet.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    from = json['From'];
    to = json['To'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_id'] = timeId;
    data['From'] = from;
    data['To'] = to;
    return data;
  }
}
