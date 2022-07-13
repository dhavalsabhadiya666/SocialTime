import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/add_application_detail_model.dart';
import 'package:pinmetar_app/model/applicant_edit_model.dart';
import 'package:pinmetar_app/model/application_job_list_model.dart';
import 'package:pinmetar_app/model/get_post_model.dart';
import 'package:pinmetar_app/model/response_model.dart';
import 'package:pinmetar_app/model/skill_model.dart';
import 'package:pinmetar_app/model/user_profile_model.dart';

Dio dio = Dio();

Future<ResponseModel?> addApplicantDetailsApi(
    AddApplicantDetailsModel addApplicantDetailsModel,
    List cvCertificate,
    String profileImage,
    String profileVideo) async {
  print('addApplicantDetailsModel pass  ${addApplicantDetailsModel.toJson()}');
  String? apiToken = await Shared_Preferences.prefGetString(
      Shared_Preferences.keyApiToken, '');
  print('apiToken  ${apiToken}');
  try {
    Response response;
    FormData formData = FormData.fromMap(addApplicantDetailsModel.toJson());
    print('cv_certificate 1111  ${cvCertificate.toString()}');
    print('profile_image --->  ${profileImage.toString()}');
    print('profile_video  ${profileVideo.toString()}');
    if (cvCertificate.isNotEmpty) {
      for(int i = 0; i < cvCertificate.length; i++) {
        formData.files.add(
          MapEntry("cv_certificate[$i]",
              await MultipartFile.fromFile(cvCertificate[i].toString())),
        );
      }
      // formData.files.add(
      //   MapEntry("cv_certificate",
      //       await MultipartFile.fromFile(cvCertificate.toString())),
      // );
    }
    if (profileImage.toString() != '') {
      formData.files.add(
        MapEntry("profile_image",
            await MultipartFile.fromFile(profileImage.toString())),
      );
    }
    if (profileVideo.toString() != '') {
      formData.files.add(
        MapEntry("profile_video",
            await MultipartFile.fromFile(profileVideo.toString())),
      );
    }

    response = await dio.post(Urls.saveApplicantUrl,
        options: Options(headers: {
          "Accept": "*/*",
          "Content-Type": 'application/json',
          'Authorization': 'Bearer ${apiToken.toString()}',
          // 'Accept-Encoding': 'gzip, deflate, br',
        }),
        data: formData);
    print('addApplicantDetails --statusCode--- > ${response.statusCode}');
    print('addApplicantDetails ----data- > ${response.data}');
    print('addApplicantDetails ----data- > ${response.statusMessage}');
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print('addApplicantDetails ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<EditApplicantModel?> getApplicantDetailsApi() async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(
        Shared_Preferences.keyApiToken, '');
    print('get apiToken ----- > ${apiToken}');
    Response response;
    response = await dio.get(
      Urls.editApplicantUrl,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization': 'Bearer ${apiToken.toString()}'
      }),
    );
    if (response.statusCode == 200) {
      EditApplicantModel responseData =
          EditApplicantModel.fromJson(response.data);
      print('get applicantEdit ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<GetPostModel?> getPostApi({int? page,String? search,String? location}) async {
  try {
    // String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;

    FormData formData = FormData.fromMap({'page': page.toString(), 'filters[search]': search,"filters[location]":location});
    response = await dio.post(
      Urls.getPostUrl,
      options: Options(headers: {
        "Content-Type": 'multipart/form-data',
        'Accept-Encoding':'gzip, deflate, br'
        //'Authorization':'Bearer ${apiToken.toString()}'
      }),
      data: formData
    );
    if (response.statusCode == 200) {
      GetPostModel responseData = GetPostModel.fromJson(response.data);
      print('get post ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<GetUserProfileModel?> getUserProfileApi() async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(
        Shared_Preferences.keyApiToken, '');
    Response response;
    response = await dio.get(
      Urls.getProfile,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization': 'Bearer ${apiToken.toString()}'
      }),
    );
    if (response.statusCode == 200) {
      GetUserProfileModel responseData =
          GetUserProfileModel.fromJson(response.data);
      print('get GetUserProfileModel ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}


Future<ResponseModel?> addJobListApi(int listType,String postId) async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken, '');
    Response response;
    response = await dio.post(
      Urls.addJobList,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization': 'Bearer ${apiToken.toString()}'
      }),
      data: {
        'list_type':listType,
        'post_id':postId
      }
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print(' addJobList ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ApplicantJobListModel?> applicantJobListApi(int listType) async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.applicantJobList,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization': 'Bearer ${apiToken.toString()}'
        }),
        data: {
          'list_type':listType,
        }
    );
    if (response.statusCode == 200) {
      ApplicantJobListModel responseData = ApplicantJobListModel.fromJson(response.data);
      print(' applicantJobListApi ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<GetSkillModel?> getSkillApi() async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.get(
        Urls.getSkills,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization': 'Bearer ${apiToken.toString()}'
        }),
    );
    if (response.statusCode == 200) {
      GetSkillModel responseData = GetSkillModel.fromJson(response.data);
      print(' GetSkillModel ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ResponseModel?> addOtherSkillApi(String skill) async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
      Urls.addSaveSkill,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization': 'Bearer ${apiToken.toString()}'
      }),
      data: {
        'skill':skill
      }
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print(' addOtherSkillApi ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}

Future<ResponseModel?> likeVideo(String postVideoId) async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.likeVideo,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization': 'Bearer ${apiToken.toString()}'
        }),
        data: {
          'post_video_id':postVideoId
        }
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print(' likeVideo ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}
