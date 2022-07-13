// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  Data11? data;
  String? message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data11.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class Data11 {
  Data11();

  factory Data11.fromJson(Map<String, dynamic> json) => Data11(
  );

  Map<String, dynamic> toJson() => {
  };
}
