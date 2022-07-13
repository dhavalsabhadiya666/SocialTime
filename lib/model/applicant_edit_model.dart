// To parse this JSON data, do
//
//     final editApplicantModel = editApplicantModelFromJson(jsonString);

import 'dart:convert';

EditApplicantModel editApplicantModelFromJson(String str) => EditApplicantModel.fromJson(json.decode(str));

String editApplicantModelToJson(EditApplicantModel data) => json.encode(data.toJson());

class EditApplicantModel {
  EditApplicantModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  EditApplicantData? data;
  String? message;

  factory EditApplicantModel.fromJson(Map<String, dynamic> json) => EditApplicantModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : EditApplicantData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class EditApplicantData {
  EditApplicantData({
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
    this.coinsToBecomeFriend,
    this.balance,
    this.security,
    this.sendNotification,
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
  List<String>? cvCertificate;
  int? coinsToBecomeFriend;
  int? balance;
  int? security;
  int? sendNotification;
  String? userId;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory EditApplicantData.fromJson(Map<String, dynamic> json) => EditApplicantData(
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
    cvCertificate: json["cv_certificate"] == null ? null : List<String>.from(json["cv_certificate"].map((x) => x)),
    coinsToBecomeFriend: json["coins_to_become_friend"] == null ? null : json["coins_to_become_friend"],
    balance: json["balance"] == null ? null : json["balance"],
    security: json["security"] == null ? null : json["security"],
    sendNotification: json["send_notification"] == null ? null : json["send_notification"],
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
    "cv_certificate": cvCertificate == null ? null : List<dynamic>.from(cvCertificate!.map((x) => x)),
    "coins_to_become_friend": coinsToBecomeFriend == null ? null : coinsToBecomeFriend,
    "balance": balance == null ? null : balance,
    "security": security == null ? null : security,
    "send_notification": sendNotification == null ? null : sendNotification,
    "user_id": userId == null ? null : userId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
