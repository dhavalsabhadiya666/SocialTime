// To parse this JSON data, do
//
//     final likeApplicantModel = likeApplicantModelFromJson(jsonString);

import 'dart:convert';

LikeApplicantModel likeApplicantModelFromJson(String str) => LikeApplicantModel.fromJson(json.decode(str));

String likeApplicantModelToJson(LikeApplicantModel data) => json.encode(data.toJson());

class LikeApplicantModel {
  LikeApplicantModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  LikeDataModel? data;
  String? message;

  factory LikeApplicantModel.fromJson(Map<String, dynamic> json) => LikeApplicantModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : LikeDataModel.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class LikeDataModel {
  LikeDataModel({
    this.like,
  });

  int? like;

  factory LikeDataModel.fromJson(Map<String, dynamic> json) => LikeDataModel(
    like: json["like"] == null ? null : json["like"],
  );

  Map<String, dynamic> toJson() => {
    "like": like == null ? null : like,
  };
}




