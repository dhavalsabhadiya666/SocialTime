// To parse this JSON data, do
//
//     final homeListModel = homeListModelFromJson(jsonString);

import 'dart:convert';

HomeListModel homeListModelFromJson(String str) => HomeListModel.fromJson(json.decode(str));

String homeListModelToJson(HomeListModel data) => json.encode(data.toJson());

class HomeListModel {
  HomeListModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  HomeListData? data;
  String? message;

  factory HomeListModel.fromJson(Map<String, dynamic> json) => HomeListModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : HomeListData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class HomeListData {
  HomeListData({
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
  List<HomeListDatum>? data;
  String? firstPageUrl;
  int? from;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory HomeListData.fromJson(Map<String, dynamic> json) => HomeListData(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<HomeListDatum>.from(json["data"].map((x) => HomeListDatum.fromJson(x))),
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

class HomeListDatum {
  HomeListDatum({
    this.applicantId,
    this.profileImage,
    this.profileVideo,
    this.name,
    this.title,
    this.dob,
    this.mobile,
    this.location,
    this.employmentType,
    this.skill,
    this.cvCertificate,
    this.userId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  String? applicantId;
  String? profileImage;
  String? profileVideo;
  String? name;
  String? title;
  String? dob;
  String? mobile;
  String? location;
  int? employmentType;
  String? skill;
  String? cvCertificate;
  String? userId;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HomeListDatum.fromJson(Map<String, dynamic> json) => HomeListDatum(
    applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
    profileVideo: json["profile_video"] == null ? null : json["profile_video"],
    name: json["name"] == null ? null : json["name"],
    title: json["title"] == null ? null : json["title"],
    dob: json["dob"] == null ? null : json["dob"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    location: json["location"] == null ? null : json["location"],
    employmentType: json["employment_type"] == null ? null : json["employment_type"],
    skill: json["skill"] == null ? null : json["skill"],
    cvCertificate: json["cv_certificate"] == null ? null : json["cv_certificate"],
    userId: json["user_id"] == null ? null : json["user_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "applicant_id": applicantId == null ? null : applicantId,
    "profile_image": profileImage == null ? null : profileImage,
    "profile_video": profileVideo == null ? null : profileVideo,
    "name": name == null ? null : name,
    "title": title == null ? null : title,
    "dob": dob == null ? null : dob,
    "mobile": mobile == null ? null : mobile,
    "location": location == null ? null : location,
    "employment_type": employmentType == null ? null : employmentType,
    "skill": skill == null ? null : skill,
    "cv_certificate": cvCertificate == null ? null : cvCertificate,
    "user_id": userId == null ? null : userId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
