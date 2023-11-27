// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

List<BranchModel> branchModelFromJson(String str) => List<BranchModel>.from(json.decode(str).map((x) => BranchModel.fromJson(x)));

String branchModelToJson(List<BranchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchModel {
  String branchId;
  String branchName;
  String branchAddress;
  String branchLat;
  String branchLong;

  BranchModel({
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchLat,
    required this.branchLong,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    branchId: json["branch_id"].toString(),
    branchName: json["branch_name"].toString(),
    branchAddress: json["branch_address"].toString(),
    branchLat: json["branch_lat"].toString(),
    branchLong: json["branch_long"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "branch_address": branchAddress,
    "branch_lat": branchLat,
    "branch_long": branchLong,
  };
}
