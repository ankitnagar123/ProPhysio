class PatinetbookingList {
  String? bookingId;
  String? doctorId;
  String? name;
  String? surname;
  String? bookingDate;
  String? status;
  String? time;

  PatinetbookingList(
      {this.bookingId,
        this.doctorId,
        this.name,
        this.surname,
        this.bookingDate,
        this.status,
        this.time,});

  PatinetbookingList.fromJson(Map<String, dynamic> json) {
    bookingId = json['book_ID'];
    doctorId = json['doctor_id'];
    name = json['name'];
    surname = json['surname'];
    bookingDate = json['booking_date'];
    status = json['status'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['doctor_id'] = doctorId;
    data['name'] = name;
    data['surname'] = surname;
    data['booking_date'] = bookingDate;
    data['status'] = status;
    data['Time'] = time;
    return data;
  }
}
