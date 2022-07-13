// To parse this JSON data, do
//
//     final addFollowModel = addFollowModelFromJson(jsonString);

import 'dart:convert';

AddFollowModel addFollowModelFromJson(String str) => AddFollowModel.fromJson(json.decode(str));

String addFollowModelToJson(AddFollowModel data) => json.encode(data.toJson());

class AddFollowModel {
  AddFollowModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  FollowData? data;
  String? message;

  factory AddFollowModel.fromJson(Map<String, dynamic> json) => AddFollowModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : FollowData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class FollowData {
  FollowData({
    this.follow,
  });

  int? follow;

  factory FollowData.fromJson(Map<String, dynamic> json) => FollowData(
    follow: json["follow"] == null ? null : json["follow"],
  );

  Map<String, dynamic> toJson() => {
    "follow": follow == null ? null : follow,
  };
}
