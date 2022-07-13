
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/user_model.dart';
import 'package:pinmetar_app/model/user_profile_model.dart';

Dio dio =  Dio();

Future<UserModel?> loginRep({String? name, String? mobile, int? signupWith, String? signupId, String? deviceId,String? email  } ) async {
  try {
    Response response;
    response = await dio.post(
      Urls.loginURl,
      options: Options(headers: {
        "Content-Type": 'application/json',
      }),
      data: {
        "name":name,
        "mobile": mobile,
        "signup_with":signupWith,
        "signup_id": signupId,
        "device_id":deviceId,
        "email":email
    }
    );
    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(response.data);
      print('user res ----- > ${response.data}');
      return userModel;
    } else {
      throw new Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}




