

import 'dart:convert';

ReviewListModel reviewListModelFromJson(String str) => ReviewListModel.fromJson(json.decode(str));

String reviewListModelToJson(ReviewListModel data) => json.encode(data.toJson());

class ReviewListModel {
  ReviewListModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  ReviewListDataModel? data;
  String? message;

  factory ReviewListModel.fromJson(Map<String, dynamic> json) => ReviewListModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : ReviewListDataModel.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class ReviewListDataModel {
  ReviewListDataModel({
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
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory ReviewListDataModel.fromJson(Map<String, dynamic> json) => ReviewListDataModel(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    nextPageUrl: json["next_page_url"],
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
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
  };
}

class Datum {
  Datum({
    this.applicantReviewId,
    this.message,
    this.applicantId,
    this.reviewbyId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.profileImage,
  });

  String? applicantReviewId;
  String? message;
  String? applicantId;
  String? reviewbyId;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    applicantReviewId: json["applicant_review_id"] == null ? null : json["applicant_review_id"],
    message: json["message"] == null ? null : json["message"],
    applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
    reviewbyId: json["reviewby_id"] == null ? null : json["reviewby_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"] == null ? null : json["name"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "applicant_review_id": applicantReviewId == null ? null : applicantReviewId,
    "message": message == null ? null : message,
    "applicant_id": applicantId == null ? null : applicantId,
    "reviewby_id": reviewbyId == null ? null : reviewbyId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "name": name == null ? null : name,
    "profile_image": profileImage == null ? null : profileImage,
  };
}
