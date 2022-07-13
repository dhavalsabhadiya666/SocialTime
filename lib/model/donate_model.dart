// To parse this JSON data, do
//
//     final donateModel = donateModelFromJson(jsonString);

import 'dart:convert';

DonateModel donateModelFromJson(String str) => DonateModel.fromJson(json.decode(str));

String donateModelToJson(DonateModel data) => json.encode(data.toJson());

class DonateModel {
  DonateModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  DonateData? data;
  String? message;

  factory DonateModel.fromJson(Map<String, dynamic> json) => DonateModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : DonateData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class DonateData {
  DonateData();

  factory DonateData.fromJson(Map<String, dynamic> json) => DonateData(
  );

  Map<String, dynamic> toJson() => {
  };
}
