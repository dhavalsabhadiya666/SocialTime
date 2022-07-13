// To parse this JSON data, do
//
//     final galleryModel = galleryModelFromJson(jsonString);

import 'dart:convert';

GalleryModel galleryModelFromJson(String str) => GalleryModel.fromJson(json.decode(str));

String galleryModelToJson(GalleryModel data) => json.encode(data.toJson());

class GalleryModel {
  GalleryModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<GalleryDataModel>? data;
  String? message;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<GalleryDataModel>.from(json["data"].map((x) => GalleryDataModel.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message == null ? null : message,
  };
}

class GalleryDataModel {
  GalleryDataModel({
    this.mediaId,
    this.media,
    this.mediaType,
    this.isActive,
    this.createdAt,
    this.thumbnail,
  });

  int? mediaId;
  String? media;
  int? mediaType;
  int? isActive;
  DateTime? createdAt;
  String? thumbnail;

  factory GalleryDataModel.fromJson(Map<String, dynamic> json) => GalleryDataModel(
    mediaId: json["media_id"] == null ? null : json["media_id"],
    media: json["media"] == null ? null : json["media"],
    thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
    mediaType: json["media_type"] == null ? null : json["media_type"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "media_id": mediaId == null ? null : mediaId,
    "media": media == null ? null : media,
    "thumbnail": thumbnail == null ? null : thumbnail,
    "media_type": mediaType == null ? null : mediaType,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}
