

import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/response_model.dart';
import 'package:pinmetar_app/model/user_profile_model.dart';

Dio dio =Dio();

Future<GetUserProfileModel?> getUserProfileApi() async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.get(
      Urls.getProfile,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization':'Bearer ${apiToken.toString()}'
      }),
    );
    if (response.statusCode == 200) {
      GetUserProfileModel responseData = GetUserProfileModel.fromJson(response.data);
      print('get GetUserProfileModel ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}





Future<ResponseModel?> saveSettingsApi({String? coinsToBecomeFriend,int? security,int? sendNotification} ) async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
      Urls.saveSettings,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization':'Bearer ${apiToken.toString()}'
      }),
      data: {
        "coins_to_become_friend":coinsToBecomeFriend,
        "security":security,
        "send_notification":sendNotification
      }
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print('get saveSettingsApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}
