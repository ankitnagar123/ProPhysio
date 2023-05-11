// To parse this JSON data, do
//
//     final calculateEarningModel = calculateEarningModelFromJson(jsonString);

import 'dart:convert';

CalculateEarningModel calculateEarningModelFromJson(String str) => CalculateEarningModel.fromJson(json.decode(str));

String calculateEarningModelToJson(CalculateEarningModel data) => json.encode(data.toJson());

class CalculateEarningModel {
  CalculateEarningModel({
    required  this.startDate,
    required  this.endDate,
    required  this.totalAmount,
    required  this.list,
  });

  DateTime startDate;
  DateTime endDate;
  String totalAmount;
  List<ListElement> list;

  factory CalculateEarningModel.fromJson(Map<String, dynamic> json) => CalculateEarningModel(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    totalAmount: json["Total_amount"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "Total_amount": totalAmount,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    required this.date,
    required this.bookId,
    required this.from,
    required this.to,
    required  this.price,
  });

  DateTime date;
  String bookId;
  String from;
  String to;
  String price;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    date: DateTime.parse(json["date"]),
    bookId: json["book_id"],
    from: json["From"],
    to: json["To"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "book_id": bookId,
    "From": from,
    "To": to,
    "price": price,
  };
}
