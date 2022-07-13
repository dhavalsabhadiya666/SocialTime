

import 'dart:convert';

GetUserProfileModel getUserProfileModelFromJson(String str) => GetUserProfileModel.fromJson(json.decode(str));

String getUserProfileModelToJson(GetUserProfileModel data) => json.encode(data.toJson());

class GetUserProfileModel {
  GetUserProfileModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  UserProfileData? data;
  String? message;

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) => GetUserProfileModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : UserProfileData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class UserProfileData {
  UserProfileData({
    this.id,
    this.name,
    this.gender,
    this.profile,
    this.email,
    this.mobile,
    this.signupWith,
    this.signupId,
    this.deviceId,
    this.apiToken,
    this.refreshToken,
    this.tokenCreatedAt,
    this.expiredAt,
    this.applicantProfile,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.profileImage,
    this.profileVideo,
    this.coinsToBecomeFriend,
    this.balance,
    this.security,
    this.sendNotification,
  });

  String? id;
  String? name;
  String? gender;
  String? profile;
  String? email;
  String? mobile;
  int? signupWith;
  String? signupId;
  String? deviceId;
  String? apiToken;
  String? refreshToken;
  DateTime? tokenCreatedAt;
  DateTime? expiredAt;
  int? applicantProfile;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? profileImage;
  String? profileVideo;
  int? coinsToBecomeFriend;
  int? balance;
  int? security;
  int? sendNotification;

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    gender: json["gender"] == null ? null : json["gender"],
    profile: json["profile"] == null ? null : json["profile"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    signupWith: json["signup_with"] == null ? null : json["signup_with"],
    signupId: json["signup_id"] == null ? null : json["signup_id"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
    tokenCreatedAt: json["token_created_at"] == null ? null : DateTime.parse(json["token_created_at"]),
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    applicantProfile: json["applicant_profile"] == null ? null : json["applicant_profile"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
    profileVideo: json["profile_video"] == null ? null : json["profile_video"],
    coinsToBecomeFriend: json["coins_to_become_friend"] == null ? null : json["coins_to_become_friend"],
    balance: json["balance"] == null ? null : json["balance"],
    security: json["security"] == null ? null : json["security"],
    sendNotification: json["send_notification"] == null ? null : json["send_notification"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "gender": gender == null ? null : gender,
    "profile": profile == null ? null : profile,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
    "signup_with": signupWith == null ? null : signupWith,
    "signup_id": signupId == null ? null : signupId,
    "device_id": deviceId == null ? null : deviceId,
    "api_token": apiToken == null ? null : apiToken,
    "refresh_token": refreshToken == null ? null : refreshToken,
    "token_created_at": tokenCreatedAt == null ? null : tokenCreatedAt!.toIso8601String(),
    "expired_at": expiredAt == null ? null : expiredAt!.toIso8601String(),
    "applicant_profile": applicantProfile == null ? null : applicantProfile,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "profile_image": profileImage == null ? null : profileImage,
    "profile_video": profileVideo == null ? null : profileVideo,
    "coins_to_become_friend": coinsToBecomeFriend == null ? null : coinsToBecomeFriend,
    "balance": balance == null ? null : balance,
    "security": security == null ? null : security,
    "send_notification": sendNotification == null ? null : sendNotification,
  };
}
