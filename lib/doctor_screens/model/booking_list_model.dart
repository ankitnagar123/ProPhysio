
class bookingList {
  String? Id;
  String? id;
  String? bookID;
  String? name;
  String? bookingDate;
  String? status;
  String? bookingTime;
  String? time;

  bookingList(
      {this.Id,
        this.id,
        this.bookID,
        this.name,
        this.bookingDate,
        this.status,
        this.bookingTime,
        this.time});

  bookingList.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    id = json['id'];
    bookID = json['book_ID'];
    name = json['name'];
    bookingDate = json['booking_date'];
    status = json['status'];
    bookingTime = json['booking_time'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = Id;
    data['id'] = id;
    data['book_ID'] = bookID;
    data['name'] = name;
    data['booking_date'] = bookingDate;
    data['status'] = status;
    data['booking_time'] = bookingTime;
    data['Time'] = time;
    return data;
  }
}
