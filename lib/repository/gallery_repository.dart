

import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/gallery_model.dart';

Dio dio =  Dio();

Future<GalleryModel?> getGalleryListApi() async {
  try {
    String? apiToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.get(
      Urls.getGallery,
      options: Options(headers: {
        "Content-Type": 'application/json',
        'Authorization':'Bearer ${apiToken.toString()}'
      }),

    );
    if (response.statusCode == 200) {
      GalleryModel responseData = GalleryModel.fromJson(response.data);
      print('getGalleryListApi ----- > ${response.data}');
      return responseData;
    } else {
      throw  Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}