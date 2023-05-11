// To parse this JSON data, do
//
//     final cardListModel = cardListModelFromJson(jsonString);

import 'dart:convert';

List<CardListModel> cardListModelFromJson(String str) => List<CardListModel>.from(json.decode(str).map((x) => CardListModel.fromJson(x)));

String cardListModelToJson(List<CardListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardListModel {
  CardListModel({
    required this.cardId,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
  });

  String cardId;
  String cardHolderName;
  String cardNumber;
  String expiryMonth;
  String expiryYear;
  String cvv;

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
    cardId: json["card_id"],
    cardHolderName: json["card_holder_name"],
    cardNumber: json["card_number"],
    expiryMonth: json["expiry_month"],
    expiryYear: json["expiry_year"],
    cvv: json["cvv"],
  );

  Map<String, dynamic> toJson() => {
    "card_id": cardId,
    "card_holder_name": cardHolderName,
    "card_number": cardNumber,
    "expiry_month": expiryMonth,
    "expiry_year": expiryYear,
    "cvv": cvv,
  };
}
