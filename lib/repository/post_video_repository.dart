import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/post_video_model.dart';
import 'package:pinmetar_app/model/response_model.dart';

Dio dio = Dio();

Future<ResponseModel?> postVideoApi(PostVideoModel postVideoModel) async {
  print('postVideoModel pass  ${postVideoModel.toJson()}');
  String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken, '');

  try {
    Response response;
    FormData formData = FormData.fromMap(postVideoModel.toJson());
    print('video thumbnail -111-->  ${postVideoModel.video.toString()}');
    print('post_video 11  ${postVideoModel.thumbnail.toString()}');

    if (postVideoModel.video != null && postVideoModel.video.toString() != '') {
      print('video thumbnail -2222-->  ${postVideoModel.video.toString()}');
      formData.files.add(
        MapEntry("video",
            await MultipartFile.fromFile(postVideoModel.video.toString())),
      );
    }
    if (postVideoModel.thumbnail != null && postVideoModel.thumbnail.toString() != '') {
      print('post_video 2222  ${postVideoModel.thumbnail.toString()}');
      formData.files.add(
        MapEntry("thumbnail",
            await MultipartFile.fromFile(postVideoModel.thumbnail.toString())),
      );
    }

    response = await dio.post(Urls.saveVideo,
        options: Options(headers: {
          "Accept": "*/*",
          "Content-Type": 'application/json',
          'Authorization': 'Bearer ${apiToken.toString()}',
          // 'Accept-Encoding': 'gzip, deflate, br',
        }),
        data: formData);
    print('addApplicantDetails ----data- > ${response.data}');
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