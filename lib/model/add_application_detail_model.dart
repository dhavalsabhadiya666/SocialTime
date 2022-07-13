
import 'dart:convert';

AddApplicantDetailsModel addApplicantDetailsModelFromJson(String str) => AddApplicantDetailsModel.fromJson(json.decode(str));

String addApplicantDetailsModelToJson(AddApplicantDetailsModel data) => json.encode(data.toJson());

class AddApplicantDetailsModel {
  AddApplicantDetailsModel({
    this.applicantId,
    this.name,
    this.title,
    this.birthday,
    this.mobile,
    this.location,
    this.employmentType,
    this.skill,
  });

  String? applicantId;
  String? name;
  String? title;
  String? birthday;
  String? mobile;
  String? location;
  int? employmentType;
  String? skill;

  factory AddApplicantDetailsModel.fromJson(Map<String, dynamic> json) => AddApplicantDetailsModel(
    applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
    name: json["name"] == null ? null : json["name"],
    title: json["title"] == null ? null : json["title"],
    birthday: json["dob"] == null ? null : json["dob"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    location: json["location"] == null ? null : json["location"],
    employmentType: json["employment_type"] == null ? null : json["employment_type"],
    skill: json["skill"] == null ? null : json["skill"],
  );

  Map<String, dynamic> toJson() => {
    "applicant_id": applicantId == null ? null : applicantId,
    "name": name == null ? null : name,
    "title": title == null ? null : title,
    "dob": birthday == null ? null : birthday,
    "mobile": mobile == null ? null : mobile,
    "location": location == null ? null : location,
    "employment_type": employmentType == null ? null : employmentType,
    "skill": skill == null ? null : skill,
  };
}
