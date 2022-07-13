import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/post_fill_in_model.dart';
import 'package:pinmetar_app/model/response_model.dart';

Dio dio =  Dio();


Future<ResponseModel?> postFillIn(PostFillInModel postFillInModel) async {
  print('postFillIn Model pass  ${postFillInModel.toJson()}');
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    FormData formData = FormData.fromMap(postFillInModel.toJson());
    print('update cv file  ${postFillInModel.media.toString()}');

    if(postFillInModel.media.toString() != '' && postFillInModel.media!=null){
      formData.files.add(MapEntry("media", await MultipartFile.fromFile(postFillInModel.media.toString())),);
    }

    if(postFillInModel.thumbnail.toString() != '' && postFillInModel.thumbnail!=null){
      print('update thumbnail file  ${postFillInModel.thumbnail.toString()}');
      formData.files.add(MapEntry("thumbnail", await MultipartFile.fromFile(postFillInModel.thumbnail.toString())),);
    }
    response = await dio.post(
        Urls.savePostUrl,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization':'Bearer ${apiToken.toString()}'
          // 'Accept-Encoding': 'gzip, deflate, br',
        }),
        data: formData
    );
    if (response.statusCode == 200) {
      ResponseModel responseData = ResponseModel.fromJson(response.data);
      print('postFillIn  ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}