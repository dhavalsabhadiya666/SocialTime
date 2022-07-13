
import 'package:dio/dio.dart';
import 'package:pinmetar_app/api/urls.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/pocket_history_model.dart';

Dio dio = Dio();

Future<PocketHistoryModel?> pocketHistory(int page) async {
  try {
    String? apiToken = await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    Response response;
    response = await dio.post(
        Urls.pocketHistory,
        options: Options(headers: {
          "Content-Type": 'application/json',
          'Authorization': 'Bearer ${apiToken.toString()}'
        }),
        data: {
          'page':page
        }
    );
    if (response.statusCode == 200) {
      PocketHistoryModel responseData = PocketHistoryModel.fromJson(response.data);
      print(' pocketHistory api ----- > ${response.data}');
      return responseData;
    } else {
      throw Exception(response.data);
    }
  } on DioError catch (e) {
    print('Dio E  ' + e.toString());
    // throw handleError(e);
  }
}
