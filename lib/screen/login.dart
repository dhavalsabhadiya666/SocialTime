import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/user_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/screen/home/bottom_navigation_bar.dart';
import 'package:pinmetar_app/screen/register.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
   UserController? _con;

   _LoginScreenState() : super(UserController()) {
    _con = controller as UserController;
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> Future.value(false),
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        appBar: AppBar(
          backgroundColor: AppConstants.clrBlack,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                color: AppConstants.clrWhite),
            onPressed: () {},
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(AppConstants.signInWithPinMeter,
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.titleFontSize32,
                          fontFamily: AppConstants.fontPoppinsRegular)),
                  Text(AppConstants.signInWithOneOfFollowingOptions,
                      style: TextStyle(
                          color: AppConstants.clrLightGreyTxt,
                          fontSize: AppConstants.mediumFontSize15,
                          fontFamily: AppConstants.fontPoppinsRegular)),
                ],
              ),
              Column(
                children: [
                  CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(8),
                    onTap: () {
                      _con!.signInWithGoogle().then((value) async {
                        if(value != null){
                          String deviceToken ='';
                          await  Shared_Preferences.prefGetString(
                              Shared_Preferences.keyDeviceToken, '')
                              .then((value) {
                            if (value != null) {
                              deviceToken = value;
                            }
                          });

                          _con!.loginApi(context,email: value.email.toString(),name: value.displayName.toString(),signupWith: 3,signupId: value.uid.toString(),deviceId: deviceToken.toString());
                        }
                      });
                    },
                    color: AppConstants.clrWhite,
                    icon: true,
                    text: AppConstants.signInWithGoogle,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(AppConstants.icGoogle),
                    ),
                    radius: 12,
                    textColor: AppConstants.clrBtnBlueText,
                  ),
                  CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(8),
                    onTap: () {
                      _con!.signInWithFacebook().then((value) async{
                        if(value != null){
                          print('loginWithFb  --> ${value.user!.uid}');
                          String deviceToken ='';
                          await  Shared_Preferences.prefGetString(
                              Shared_Preferences.keyDeviceToken, '')
                              .then((value) {
                            if (value != null) {
                              deviceToken = value;
                            }
                          });
                          print('fb email  ${value.user!.email}');
                          print('fb displayName  ${value.user!.displayName}');
                          print('fb uid  ${value.user!.uid}');
                          _con!.loginApi(context,email: value.user!.email.toString(),name: value.user!.displayName.toString(),signupWith: 4,signupId: value.user!.uid.toString(),deviceId: deviceToken.toString());
                        }
                      });
                    },
                    color: AppConstants.clrWhite,
                    icon: true,
                    text: AppConstants.signInWithFacebook,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(AppConstants.icFacebook),
                    ),
                    radius: 12,
                    textColor: AppConstants.clrBtnBlueText,
                  ),
                  Platform.isAndroid ? Container()  :CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(8),
                    onTap: () {
                      _con!.signInWithApple(scopes: [Scope.email, Scope.fullName]).then((value1) async{
                        if(value1 != null){
                          String deviceToken ='';
                          await  Shared_Preferences.prefGetString(
                              Shared_Preferences.keyDeviceToken, '')
                              .then((value) {
                            if (value != null) {
                              deviceToken = value;
                            }
                          });
                          _con!.loginApi(context,email: value1.email.toString(),name: value1.displayName.toString(),signupWith: 5,signupId:value1.uid.toString(),deviceId: deviceToken.toString());
                        }
                      });
                    },
                    color: AppConstants.clrWhite,
                    icon: true,
                    text: AppConstants.signInWithApple,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(AppConstants.icApple),
                    ),
                    radius: 12,
                    textColor: AppConstants.clrBtnBlueText,
                  ),
                  CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    onTap: () async {
                      String deviceToken ='';
                      await  Shared_Preferences.prefGetString(
                          Shared_Preferences.keyDeviceToken, '')
                          .then((value) {
                        if (value != null) {
                          deviceToken = value;
                        }
                      });
                      _con!.loginApi(context,name: 'user1',mobile: '1234567890',signupWith: 1,signupId: '1233',deviceId: deviceToken.toString(),email: 'test@gmail.com');

                    },
                    color: AppConstants.clrButtonGreen,
                    icon: true,
                    text: AppConstants.signInWithWeChat,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Image.asset(AppConstants.wechat_image_button),
                    radius: 12,
                    textColor: AppConstants.clrWhite,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    onTap: () async {
                      String deviceToken ='';
                      await  Shared_Preferences.prefGetString(
                          Shared_Preferences.keyDeviceToken, '')
                          .then((value) {
                        if (value != null) {
                          deviceToken = value;
                        }
                      });
                      _con!.loginApi(context,name: 'user2',mobile: '0987654321',signupWith: 2,signupId: '4567',deviceId: deviceToken.toString(),email: 'test@gmail.com');
                    },
                    color: AppConstants.clrBtnGrey,
                    icon: true,
                    text: AppConstants.signInWithAlipay,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Image.asset(AppConstants.alipay_image_button),
                    radius: 12,
                    textColor: AppConstants.clrBtnBlueText,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CustomBottomNavigationBar(0)));
                      },
                      child: const Text(
                        AppConstants.skipSignUp,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize17,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrSkyBlueTxt),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    AppConstants.alreadyHaveAnAccount,
                    style: TextStyle(
                        color: AppConstants.clrGreyText,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      "  ${AppConstants.signUp}",
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize12),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
