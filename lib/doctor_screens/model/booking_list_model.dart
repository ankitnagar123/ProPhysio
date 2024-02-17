// To parse this JSON data, do
//
//     final bookingList = bookingListFromJson(jsonString);

import 'dart:convert';

List<BookingList> bookingListFromJson(String str) => List<BookingList>.from(json.decode(str).map((x) => BookingList.fromJson(x)));

String bookingListToJson(List<BookingList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingList {
  String id;
  String bookingId;
  String userId;
  String bookId;
  String name;
  String bookingDate;
  String status;
  String time;
  String cancelReason;

  BookingList({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.bookId,
    required this.name,
    required this.bookingDate,
    required this.status,
    required this.time,
    required this.cancelReason,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
    id: json["Id"].toString(),
    bookingId: json["booking_id"].toString(),
    userId: json["user_id"].toString(),
    bookId: json["book_ID"].toString(),
    name: json["name"].toString(),
    bookingDate: json["booking_date"].toString(),
    status: json["status"].toString(),
    time: json["Time"].toString(),
    cancelReason: json["cancel_reason"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "booking_id": bookingId,
    "user_id": userId,
    "book_ID": bookId,
    "name":name,
    "booking_date": bookingDate,
    "status": status,
    "Time": time,
    "cancel_reason": cancelReason,
  };
}
