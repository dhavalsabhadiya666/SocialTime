import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/add_follower_model.dart';
import 'package:pinmetar_app/model/applicant_detail_model.dart';
import 'package:pinmetar_app/model/donate_model.dart';
import 'package:pinmetar_app/model/home_list_model.dart';
import 'package:pinmetar_app/model/like_applicant_model.dart';
import 'package:pinmetar_app/model/response_model.dart';
import 'package:pinmetar_app/model/review_list_model.dart';

Dio dio =  Dio();

Future<HomeListModel?> getHomeListApi(int page, {String? search,String? category}) async {

  print('search  ${search}');
  print('getHomeListUrl  ${  Urls.getHomeListUrl}');
  var data=jsonEncode('page: $page,filters[search]: $search');
  print('data  ${data}');
  try {
    // String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    FormData formData = FormData.fromMap({'page': page.toString(),
      'filters[search]': search,'filters[category]':category});
    response = await dio.post(
      Urls.getHomeListUrl,
      options: Options(headers: {
        "Content-Type": 'multipart/form-data',
        'Accept-Encoding':'gzip, deflate, br'
        //'Authorization':'Bearer ${apiToken.toString()}'
      }),
      data:formData
    );
    if (response.statusCode == 200) {
      HomeListModel responseData = HomeListModel.fromJson(response.data);
      print('get post Home list ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<HomeListModel?> getFollowersListApi() async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.get(
        Urls.getFollowers,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),

    );
    if (response.statusCode == 200) {
      HomeListModel responseData = HomeListModel.fromJson(response.data);
      print('get getFollowersListApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ApplicantDetailModel?> getApplicantDetailApi(String applicantId) async {
  try {
    // String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.getApplicantDetailUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          //'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId
        }
    );
    if (response.statusCode == 200) {
      ApplicantDetailModel responseData = ApplicantDetailModel.fromJson(response.data);
      print('get ApplicantDetailModel ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<LikeApplicantModel?> likeApplicantApi(String applicantId) async {
  try {
     String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.likeApplicantUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId
        }
    );
    if (response.statusCode == 200) {
      LikeApplicantModel responseData = LikeApplicantModel.fromJson(response.data);
      print(' LikeApplicantModel ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<AddFollowModel?> addFollowerApi(String applicantId) async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.addFollowerUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId
        }
    );
    if (response.statusCode == 200) {
      AddFollowModel responseData = AddFollowModel.fromJson(response.data);
      print(' AddFollowModel ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ResponseModel?> addReviewApi(String applicantId,String message) async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    print('apiToken   ${apiToken}');
    Response response;
    response = await dio.post(
        Urls.addReviewUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId,
          "message": message
        }
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print(' addReviewApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ReviewListModel?> getReviewListApi(String applicantId,int page) async {
  try {
     String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.getReviewUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId,
          "page": page
        }
    );
    if (response.statusCode == 200) {
      ReviewListModel responseData = ReviewListModel.fromJson(response.data);
      print('get getReviewListApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ResponseModel?> saveMediaReportApi(String applicantId,String media,String message ) async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.saveMediaReport,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId,
          "media": media,
          "message": message
        }
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print('saveMediaReportApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<DonateModel?> donateApi(String applicantId) async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.getDonateUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId
        }
    );
    if (response.statusCode == 200) {
      DonateModel responseData = DonateModel.fromJson(response.data);
      print('donateApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<DonateModel?> purchaseCoinsApi(String applicantId,int coins) async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.purchaseCoins,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
        }),
        data: {
          "applicant_id": applicantId,
          "coins": coins
        }
    );
    if (response.statusCode == 200) {
      DonateModel responseData = DonateModel.fromJson(response.data);
      print(' purchaseCoinsApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}



