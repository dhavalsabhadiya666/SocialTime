

import 'dart:convert';

PostFillInModel postFillInModelFromJson(String str) => PostFillInModel.fromJson(json.decode(str));

String postFillInModelToJson(PostFillInModel data) => json.encode(data.toJson());

class PostFillInModel {
  PostFillInModel({
    this.postId,
    this.title,
    this.time,
    this.comment,
    this.location,
    this.media,
    this.thumbnail
  });

  String? postId;
  String? title;
  String? time;
  String? comment;
  String? location;
  String? media;
  String? thumbnail;

  factory PostFillInModel.fromJson(Map<String, dynamic> json) => PostFillInModel(
    postId: json["post_id"] == null ? null : json["post_id"],
    title: json["title"] == null ? null : json["title"],
    time: json["time"] == null ? null : json["time"],
    comment: json["comment"] == null ? null : json["comment"],
    location: json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId == null ? null : postId,
    "title": title == null ? null : title,
    "time": time == null ? null : time,
    "comment": comment == null ? null : comment,
    "location": location == null ? null : location,
  };
}
