// To parse this JSON data, do
//
//     final getSkillModel = getSkillModelFromJson(jsonString);

import 'dart:convert';

GetSkillModel getSkillModelFromJson(String str) => GetSkillModel.fromJson(json.decode(str));

String getSkillModelToJson(GetSkillModel data) => json.encode(data.toJson());

class GetSkillModel {
  GetSkillModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<GetSkillData>? data;
  String? message;

  factory GetSkillModel.fromJson(Map<String, dynamic> json) => GetSkillModel(
    success: json["success"],
    data: List<GetSkillData>.from(json["data"].map((x) => GetSkillData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class GetSkillData {
  GetSkillData({
    this.skillId,
    this.skill,
    this.isActive,
    this.createdAt,
  });

  String? skillId;
  String? skill;
  int? isActive;
  DateTime? createdAt;

  factory GetSkillData.fromJson(Map<String, dynamic> json) => GetSkillData(
    skillId: json["skill_id"],
    skill: json["skill"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "skill_id": skillId,
    "skill": skill,
    "is_active": isActive,
    "created_at": createdAt!.toIso8601String(),
  };
}
