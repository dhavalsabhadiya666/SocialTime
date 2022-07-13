import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/user_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/screen/login.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends StateMVC<RegisterScreen> {
  UserController? _con;

  _RegisterScreenState() : super(UserController()) {
    _con = controller as UserController;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(AppConstants.signUpWithPinMeter,
                    style: TextStyle(
                        color: AppConstants.clrWhite,
                        fontSize: AppConstants.titleFontSize32,
                        fontFamily: AppConstants.fontPoppinsRegular)),
                Text(AppConstants.signUpWithOneOfFollowingOptions,
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

                        _con!.loginApi(context,email: value.email.toString(),name: value.displayName.toString(),mobile: '+919895698745',signupWith: 1,signupId: value.uid.toString(),deviceId: 'hfgdj');
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
                        _con!.loginApi(context,email: value.user!.email.toString(),name: value.user!.displayName.toString(),mobile: '+919895698745',signupWith: 1,signupId: value.user!.uid.toString(),deviceId: 'hfgdj');
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
                Platform.isAndroid ? Container()  :     CustomButton(
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
                        _con!.loginApi(context,email: value1.email.toString(),name: value1.displayName.toString(),mobile: '+919895698745',signupWith: 1,signupId: value1.uid.toString(),deviceId: 'hfgdj');
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
                  onTap: () {
                    _con!.loginApi(context,name: 'user1',mobile: '1234567890',signupWith: 1,signupId: '1233',deviceId: "qwerrtyuiop");

                  },
                  color: AppConstants.clrButtonGreen,
                  icon: true,
                  text: AppConstants.signUpWithWeChat,
                  fontFamily: AppConstants.fontPoppinsRegular,
                  fontSize: AppConstants.mediumFontSize18,
                  image: Image.asset(AppConstants.wechat_image_button),
                  radius: 12,
                  textColor: AppConstants.clrWhite,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  width: AppConstants.displayWidth(context),
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  onTap: () {
                    _con!.loginApi(context,name: 'user2',mobile: '0987654321',signupWith: 2,signupId: '4567',deviceId: "qwerrtyuiop");
                  },
                  color: AppConstants.clrBtnGrey,
                  icon: true,
                  text: AppConstants.signUpWithAlipay,
                  fontFamily: AppConstants.fontPoppinsRegular,
                  fontSize: AppConstants.mediumFontSize18,
                  image: Image.asset(AppConstants.alipay_image_button),
                  radius: 12,
                  textColor: AppConstants.clrBtnBlueText,
                ),
                const SizedBox(height: 25),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      AppConstants.skipSignIn,
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize17,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrSkyBlueTxt),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    AppConstants.alreadyHaveAnAccount,
                    style: TextStyle(
                        color: AppConstants.clrGreyText,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "  ${AppConstants.signIn}",
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
