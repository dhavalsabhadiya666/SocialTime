

import 'dart:convert';

import 'dart:io';

PostVideoModel postVideoModelFromJson(String str) => PostVideoModel.fromJson(json.decode(str));

String postVideoModelToJson(PostVideoModel data) => json.encode(data.toJson());

class PostVideoModel {
  PostVideoModel({
    this.postVideoId,
    this.description,
    this.hashtags,
    this.friends,
    this.videoPrivacy,
    this.allowDownload,
    this.video,
this.thumbnail
  });

  String? postVideoId;
  String? description;
  String? hashtags;
  String? friends;
  int? videoPrivacy;
  int? allowDownload;
  String ? video;
  String? thumbnail;


  factory PostVideoModel.fromJson(Map<String, dynamic> json) => PostVideoModel(
    postVideoId: json["post_video_id"] == null ? null : json["post_video_id"],
    description: json["description"] == null ? null : json["description"],
    hashtags: json["hashtags"] == null ? null : json["hashtags"],
    friends: json["friends"] == null ? null : json["friends"],
    videoPrivacy: json["video_privacy"] == null ? null : json["video_privacy"],
    allowDownload: json["allow_download"] == null ? null : json["allow_download"],
  );

  Map<String, dynamic> toJson() => {
    "post_video_id": postVideoId == null ? null : postVideoId,
    "description": description == null ? null : description,
    "hashtags": hashtags == null ? null : hashtags,
    "friends": friends == null ? null : friends,
    "video_privacy": videoPrivacy == null ? null : videoPrivacy,
    "allow_download": allowDownload == null ? null : allowDownload,
  };
}
