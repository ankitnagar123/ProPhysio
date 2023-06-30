// To parse this JSON data, do
//
//     final doctorbooingRatingList = doctorbooingRatingListFromJson(jsonString);

import 'dart:convert';

List<DoctorbooingRatingList> doctorbooingRatingListFromJson(String str) => List<DoctorbooingRatingList>.from(json.decode(str).map((x) => DoctorbooingRatingList.fromJson(x)));

String doctorbooingRatingListToJson(List<DoctorbooingRatingList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorbooingRatingList {
  String bookingId;
  String doctorId;
  String bookId;
  String name;
  String surname;
  String bookingDate;
  String status;
  String time;

  DoctorbooingRatingList({
    required this.bookingId,
    required this.doctorId,
    required this.bookId,
    required this.name,
    required this.surname,
    required this.bookingDate,
    required this.status,
    required this.time,
  });

  factory DoctorbooingRatingList.fromJson(Map<String, dynamic> json) => DoctorbooingRatingList(
    bookingId: json["booking_id"],
    doctorId: json["doctor_id"],
    bookId: json["book_ID"],
    name: json["name"],
    surname: json["surname"],
    bookingDate:json["booking_date"],
    status:json["status"] ,
    time: json["Time"],
  );

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
    "doctor_id": doctorId,
    "book_ID": bookId,
    "name": name,
    "surname": surname,
    "booking_date": bookingDate,
    "status": status,
    "Time": time,
  };
}

enum Name { ZEBRA, AHGJHGJHGHG, SIMONE, ASASASAA, ASHISH, EMPTY, MARTA1, MARTINA, EMMA, SIMONA }

final nameValues = EnumValues({
  "ahgjhgjhghg": Name.AHGJHGJHGHG,
  "asasasaa": Name.ASASASAA,
  "Ashish": Name.ASHISH,
  "Emma": Name.EMMA,
  "": Name.EMPTY,
  "Marta1": Name.MARTA1,
  "Martina": Name.MARTINA,
  "Simona": Name.SIMONA,
  "simone": Name.SIMONE,
  "Zebra": Name.ZEBRA
});

enum Status { COMPLETE }

final statusValues = EnumValues({
  "Complete": Status.COMPLETE
});

enum Surname { ANIMAL, SDASDSDS, CONTI, ASSSSSSSS, NEHRA, RODOLFI, RIZZO, SMITH, FRANCINI }

final surnameValues = EnumValues({
  "Animal": Surname.ANIMAL,
  "assssssss": Surname.ASSSSSSSS,
  "conti": Surname.CONTI,
  "Francini": Surname.FRANCINI,
  "Nehra": Surname.NEHRA,
  "Rizzo": Surname.RIZZO,
  "Rodolfi": Surname.RODOLFI,
  "sdasdsds": Surname.SDASDSDS,
  "Smith": Surname.SMITH
});

enum Time { THE_00000000 }

final timeValues = EnumValues({
  "00:00-00:00": Time.THE_00000000
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
