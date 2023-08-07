/*
class RatingListModel {
  String? aveRating;
  int? totalReview;
  List<Users>? users;

  RatingListModel({this.aveRating, this.totalReview, this.users});

  RatingListModel.fromJson(Map<String, dynamic> json) {
    aveRating = json['ave_rating'];
    totalReview = json['total_review'];
    if (json['Users'] != null) {
      users = <Users>[];
      json['Users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ave_rating'] = aveRating;
    data['total_review'] = totalReview;
    if (users != null) {
      data['Users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? userName;
  String? rating;
  String? review;
  String? date;
  String? time;

  Users({this.userName, this.rating, this.review, this.date, this.time});

  Users.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    rating = json['rating'];
    review = json['review'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['rating'] = rating;
    data['review'] = review;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
*/
// To parse this JSON data, do
//
//     final ratingListModel = ratingListModelFromJson(jsonString);

import 'dart:convert';

RatingListModel ratingListModelFromJson(String str) => RatingListModel.fromJson(json.decode(str));

String ratingListModelToJson(RatingListModel data) => json.encode(data.toJson());

class RatingListModel {
  RatingListModel({
    required this.aveRating,
    required this.totalReview,
    required this.users,
  });

  String aveRating;
  String totalReview;
  List<User> users;

  factory RatingListModel.fromJson(Map<String, dynamic> json) => RatingListModel(
    aveRating: json["ave_rating"].toString(),
    totalReview: json["total_review"].toString(),
    users: List<User>.from(json["Users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ave_rating": aveRating,
    "total_review": totalReview,
    "Users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  User({
    required this.userName,
    required this.rating,
    required this.review,
    required this.date,
    required this.time,
  });

  String userName;
  String rating;
  String review;
  String date;
  String time;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userName: json["user_name"].toString(),
    rating: json["rating"].toString(),
    review: json["review"].toString(),
    date: json["date"].toString(),
    time: json["time"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "rating": rating,
    "review": review,
    "date": date,
    "time": time,
  };
}
