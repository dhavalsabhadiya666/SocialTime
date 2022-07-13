

import 'dart:convert';

ApplicantJobListModel applicantJobListModelFromJson(String str) => ApplicantJobListModel.fromJson(json.decode(str));

String applicantJobListModelToJson(ApplicantJobListModel data) => json.encode(data.toJson());

class ApplicantJobListModel {
  ApplicantJobListModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<ApplicantJobListDataModel>? data;
  String? message;

  factory ApplicantJobListModel.fromJson(Map<String, dynamic> json) => ApplicantJobListModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<ApplicantJobListDataModel>.from(json["data"].map((x) => ApplicantJobListDataModel.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message == null ? null : message,
  };
}

class ApplicantJobListDataModel {
  ApplicantJobListDataModel({
    this.postId,
    this.title,
    this.time,
    this.comment,
    this.media,
    this.thumbnail,
    this.location,
    this.applicantId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.applicantJobListId,
    this.listType,
    this.applicantName,
    this.profileImage,

  });

  String? postId;
  String? title;
  String? time;
  String? comment;
  String? media;
  String? thumbnail;
  String? location;
  String? applicantId;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? applicantJobListId;
  int? listType;
  String? applicantName;
  String? profileImage;

  factory ApplicantJobListDataModel.fromJson(Map<String, dynamic> json) => ApplicantJobListDataModel(
    postId: json["post_id"] == null ? null : json["post_id"],
    title: json["title"] == null ? null : json["title"],
    time: json["time"] == null ? null : json["time"],
    comment: json["comment"] == null ? null : json["comment"],
    media: json["media"] == null ? null : json["media"],
    thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
    location: json["location"] == null ? null : json["location"],
    applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    applicantJobListId: json["applicant_job_list_id"] == null ? null : json["applicant_job_list_id"],
    listType: json["list_type"] == null ? null : json["list_type"],
    applicantName: json["applicant_name"] == null ? null : json["applicant_name"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId == null ? null : postId,
    "title": title == null ? null : title,
    "time": time == null ? null : time,
    "comment": comment == null ? null : comment,
    "media": media == null ? null : media,
    "thumbnail": thumbnail == null ? null : thumbnail,
    "location": location == null ? null : location,
    "applicant_id": applicantId == null ? null : applicantId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "applicant_job_list_id": applicantJobListId == null ? null : applicantJobListId,
    "list_type": listType == null ? null : listType,
    "applicant_name": applicantName == null ? null : applicantName,
    "profile_image": profileImage == null ? null : profileImage,
  };
}
