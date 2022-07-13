// To parse this JSON data, do
//
//     final pocketHistoryModel = pocketHistoryModelFromJson(jsonString);

import 'dart:convert';

PocketHistoryModel pocketHistoryModelFromJson(String str) => PocketHistoryModel.fromJson(json.decode(str));

String pocketHistoryModelToJson(PocketHistoryModel data) => json.encode(data.toJson());

class PocketHistoryModel {
  PocketHistoryModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  PocketHistoryData? data;
  String? message;

  factory PocketHistoryModel.fromJson(Map<String, dynamic> json) => PocketHistoryModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : PocketHistoryData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class PocketHistoryData {
  PocketHistoryData({
    this.balance,
    this.wallet,
  });

  int? balance;
  Wallet? wallet;

  factory PocketHistoryData.fromJson(Map<String, dynamic> json) => PocketHistoryData(
    balance: json["balance"] == null ? null : json["balance"],
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance == null ? null : balance,
    "wallet": wallet == null ? null : wallet!.toJson(),
  };
}

class Wallet {
  Wallet({
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

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
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
    this.walletId,
    this.applicantId,
    this.transactionType,
    this.coins,
    this.loginApplicantId,
    this.comment,
    this.createdAt,
  });

  String? walletId;
  ApplicantId? applicantId;
  int? transactionType;
  int? coins;
  ApplicantId? loginApplicantId;
  String? comment;
  DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    walletId: json["wallet_id"] == null ? null : json["wallet_id"],
    applicantId: json["applicant_id"] == null ? null : applicantIdValues.map![json["applicant_id"]],
    transactionType: json["transaction_type"] == null ? null : json["transaction_type"],
    coins: json["coins"] == null ? null : json["coins"],
    loginApplicantId: json["login_applicant_id"] == null ? null : applicantIdValues.map![json["login_applicant_id"]],
    comment: json["comment"] == null ? null : json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId == null ? null : walletId,
    "applicant_id": applicantId == null ? null : applicantIdValues.reverse[applicantId],
    "transaction_type": transactionType == null ? null : transactionType,
    "coins": coins == null ? null : coins,
    "login_applicant_id": loginApplicantId == null ? null : applicantIdValues.reverse[loginApplicantId],
    "comment": comment == null ? null : comment,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

enum ApplicantId { B7_E4093_BBB6_D4_A2_AAEADD931487_C6_CB6 }

final applicantIdValues = EnumValues({
  "b7e4093bbb6d4a2aaeadd931487c6cb6": ApplicantId.B7_E4093_BBB6_D4_A2_AAEADD931487_C6_CB6
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
