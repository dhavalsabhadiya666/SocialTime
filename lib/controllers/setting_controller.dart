import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/model/user_profile_model.dart';
import 'package:pinmetar_app/repository/setting_repositoy.dart' as setting;

class SettingController extends ControllerMVC{



  UserProfileData userProfileData =UserProfileData();


  Future<void> getUserProfileApi(bool isLoader) async {
    // FocusScope.of(context).unfocus();
    if(isLoader==true){
      showLoader();
    }

    await setting.getUserProfileApi().then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            userProfileData =value.data!;
          });
          if(isLoader==true){
          hideLoader();}
        } else {
          if(isLoader==true){
          hideLoader();}
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      if(isLoader==true){
        hideLoader();}
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      if(isLoader==true){
      hideLoader();}
    });
  }

  Future<void> saveSettingsApi({String? coinsToBecomeFriend,int? security,int? sendNotification}) async {
    // FocusScope.of(context).unfocus();
    showLoader();
    await setting.saveSettingsApi(coinsToBecomeFriend: coinsToBecomeFriend,security: security,sendNotification: sendNotification).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            showToast(value.message.toString());
          });
          hideLoader();
        } else {
          hideLoader();
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
  }
}