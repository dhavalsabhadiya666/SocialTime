// To parse this JSON data, do
//
//     final getPostModel = getPostModelFromJson(jsonString);

import 'dart:convert';

GetPostModel getPostModelFromJson(String str) => GetPostModel.fromJson(json.decode(str));

String getPostModelToJson(GetPostModel data) => json.encode(data.toJson());

class GetPostModel {
  GetPostModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  GetPostData? data;
  String? message;

  factory GetPostModel.fromJson(Map<String, dynamic> json) => GetPostModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : GetPostData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class GetPostData {
  GetPostData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory GetPostData.fromJson(Map<String, dynamic> json) => GetPostData(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "next_page_url": nextPageUrl == null ? null : nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
  };
}

class Datum {
  Datum({
    this.postId,
    this.title,
    this.time,
    this.comment,
    this.media,
    this.thumbnail,
    this.location,
    this.applicantName,
    this.profileImage,
    this.userId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  String? postId;
  String? title;
  String? time;
  String? comment;
  String? media;
  String? thumbnail;
  String? location;
  String? applicantName;
  String? profileImage;
  UserId? userId;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    postId: json["post_id"] == null ? null : json["post_id"],
    title: json["title"] == null ? null : json["title"],
    time: json["time"] == null ? null : json["time"],
    comment: json["comment"] == null ? null : json["comment"],
    media: json["media"] == null ? null : json["media"],
    thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
    location: json["location"] == null ? null : json["location"],
    applicantName: json["applicant_name"] == null ? null : json["applicant_name"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
    userId: json["user_id"] == null ? null : userIdValues.map![json["user_id"]],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId == null ? null : postId,
    "title": title == null ? null : title,
    "time": time == null ? null : time,
    "comment": comment == null ? null : comment,
    "media": media == null ? null : media,
    "thumbnail": thumbnail == null ? null : thumbnail,
    "location": location == null ? null : location,
    "applicant_name": applicantName == null ? null : applicantName,
    "profile_image": profileImage == null ? null : profileImage,
    "user_id": userId == null ? null : userIdValues.reverse[userId],
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}

enum UserId { THE_32_C879672_A6241_ADBCD82_E641_F16245_E, THE_5_E1_D4_D4279194228_AA668561_DA10_CCAC, THE_61_CC0_BE4486944_CAA9_BE7_E97_A4_D9_F929 }

final userIdValues = EnumValues({
  "32c879672a6241adbcd82e641f16245e": UserId.THE_32_C879672_A6241_ADBCD82_E641_F16245_E,
  "5e1d4d4279194228aa668561da10ccac": UserId.THE_5_E1_D4_D4279194228_AA668561_DA10_CCAC,
  "61cc0be4486944caa9be7e97a4d9f929": UserId.THE_61_CC0_BE4486944_CAA9_BE7_E97_A4_D9_F929
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
