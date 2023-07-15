
class bookingList {

  String? bookingId;
  String? id;
  String? bookID;
  String? name;
  String? bookingDate;
  String? status;
  String? bookingTime;
  String? time;

  bookingList(
      {
        this.bookingId,
        this.id,
        this.bookID,
        this.name,
        this.bookingDate,
        this.status,
        this.bookingTime,
        this.time});

  bookingList.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    id = json['user_id'];
    bookID = json['book_ID'];
    name = json['name'];
    bookingDate = json['booking_date'];
    status = json['status'];
    bookingTime = json['booking_time'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["booking_id"] = bookingId;
    data['user_id'] = id;
    data['book_ID'] = bookID;
    data['name'] = name;
    data['booking_date'] = bookingDate;
    data['status'] = status;
    data['booking_time'] = bookingTime;
    data['Time'] = time;
    return data;
  }
}
