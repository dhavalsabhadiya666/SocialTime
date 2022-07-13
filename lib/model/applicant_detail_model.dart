// To parse this JSON data, do
//
//     final applicantDetailModel = applicantDetailModelFromJson(jsonString);

import 'dart:convert';

ApplicantDetailModel applicantDetailModelFromJson(String str) => ApplicantDetailModel.fromJson(json.decode(str));

String applicantDetailModelToJson(ApplicantDetailModel data) => json.encode(data.toJson());

class ApplicantDetailModel {
  ApplicantDetailModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  ApplicantDetailData? data;
  String? message;

  factory ApplicantDetailModel.fromJson(Map<String, dynamic> json) => ApplicantDetailModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : ApplicantDetailData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class ApplicantDetailData {
  ApplicantDetailData({
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
    this.likes,
    this.followers,
    this.reviews,
    this.videos
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
  int? likes;
  int? followers;
  int? reviews;
  List<Video>? videos;

  factory ApplicantDetailData.fromJson(Map<String, dynamic> json) => ApplicantDetailData(
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
    likes: json["likes"] == null ? null : json["likes"],
    followers: json["followers"] == null ? null : json["followers"],
    reviews: json["reviews"] == null ? null : json["reviews"],
    videos: json["videos"] == null ? null : List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "applicant_id": applicantId == null ? null : applicantId,
    "profile_image": profileImage == null ? null : profileImage,
    "profile_video": profileVideo == null ? null : profileVideo,
    "name": name == null ? null : name,
    "title": title == null ? null : title,
    "dob": dob == null ? null :dob,
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
    "likes": likes == null ? null : likes,
    "followers": followers == null ? null : followers,
    "reviews": reviews == null ? null : reviews,
    "videos": videos == null ? null : List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}

class Video {
  Video({
    this.postVideoId,
    this.video,
    this.thumbnail,
    this.description,
    this.hashtags,
    this.friends,
    this.videoPrivacy,
    this.allowDownload,
    this.applicantId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.like
  });

  String? postVideoId;
  String? video;
  String? thumbnail;
  String? description;
  String? hashtags;
  dynamic friends;
  int? videoPrivacy;
  int? allowDownload;
  String? applicantId;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? like;


  factory Video.fromJson(Map<String, dynamic> json) => Video(
    postVideoId: json["post_video_id"] == null ? null : json["post_video_id"],
    video: json["video"] == null ? null : json["video"],
    thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
    description: json["description"] == null ? null : json["description"],
    hashtags: json["hashtags"] == null ? null : json["hashtags"],
    friends: json["friends"],
    videoPrivacy: json["video_privacy"] == null ? null : json["video_privacy"],
    allowDownload: json["allow_download"] == null ? null : json["allow_download"],
    applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    like: json["like"] == null ? null : json["like"],
  );

  Map<String, dynamic> toJson() => {
    "post_video_id": postVideoId == null ? null : postVideoId,
    "video": video == null ? null : video,
    "thumbnail": thumbnail == null ? null : thumbnail,
    "description": description == null ? null : description,
    "hashtags": hashtags == null ? null : hashtags,
    "friends": friends,
    "video_privacy": videoPrivacy == null ? null : videoPrivacy,
    "allow_download": allowDownload == null ? null : allowDownload,
    "applicant_id": applicantId == null ? null : applicantId,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "like": like == null ? null : like,
  };
}


