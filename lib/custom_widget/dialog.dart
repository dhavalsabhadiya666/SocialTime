import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pinmetar_app/controllers/user_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/screen/login.dart';
import 'package:pinmetar_app/screen/me/applicant_profile_screen.dart';
import 'package:pinmetar_app/screen/me/my_video.dart';
import 'package:pinmetar_app/screen/video/camera_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';

donateDialog(
  BuildContext context, int coinCont, Function() onTap
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.db_image,
                  width: 100,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Donate Now. ',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize18,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: coinCont.toString(),
                          style: const TextStyle(
                              fontSize: AppConstants.mediumFontSize18,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrButtonGreen,
                              fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                            text: ' Coins.',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize18,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        height: 50,
                        width: AppConstants.displayWidth(context) * 0.35,
                        onTap: () => Navigator.pop(context),
                        padding: const EdgeInsets.all(10),
                        radius: 12,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        text: AppConstants.no,
                        textColor: AppConstants.clrWhite,
                        color: AppConstants.clrDialogBtnNoBg,
                        icon: false),
                    const SizedBox(width: 10),
                    CustomButton(
                        height: 50,
                        width: AppConstants.displayWidth(context) * 0.35,
                        onTap: onTap,
                        padding: const EdgeInsets.all(10),
                        radius: 12,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        text: AppConstants.yes,
                        textColor: AppConstants.clrWhite,
                        color: AppConstants.clrDialogBtnYesBg,
                        icon: false)
                  ],
                )
              ],
            ),
          ),
        );
      });
}

doneDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.done_image,
                  width: 100,
                  height: 100,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(AppConstants.thankYouForYourDonation,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        );
      });
}

donateToBecomeFanDialog(
  BuildContext context,
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.db_image,
                  width: 100,
                  height: 100,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Donate ',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize18,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: '100',
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize18,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrButtonGreen,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                            text: ' Coins to become super gold fans.',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize18,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        height: 50,
                        width: AppConstants.displayWidth(context) * 0.35,
                        onTap: () => Navigator.pop(context),
                        padding: const EdgeInsets.all(10),
                        radius: 12,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        text: AppConstants.no,
                        textColor: AppConstants.clrWhite,
                        color: AppConstants.clrDialogBtnNoBg,
                        icon: false),
                    CustomButton(
                        height: 50,
                        width: AppConstants.displayWidth(context) * 0.35,
                        onTap: () => Navigator.pop(context),
                        padding: const EdgeInsets.all(10),
                        radius: 12,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        text: AppConstants.yes,
                        textColor: AppConstants.clrWhite,
                        color: AppConstants.clrDialogBtnYesBg,
                        icon: false)
                  ],
                )
              ],
            ),
          ),
        );
      });
}

joinChatDialog(BuildContext context) {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      AppConstants.joinChatGroup,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppConstants.clrWhite,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize18),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 50, top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _value1 = !_value1;
                                    });

                                    print('asjhdfbgashjbfasf: $_value1');
                                  },
                                  child: _value1 == false
                                      ? const Icon(
                                          Icons.check_box_outline_blank,
                                          size: 25,
                                          color: AppConstants.clrWhite,
                                        )
                                      : const Icon(Icons.check_box_outlined,
                                          size: 25,
                                          color: AppConstants.clrWhite),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  AppConstants.pianistChatGroup,
                                  style: TextStyle(
                                      color: AppConstants.clrWhite,
                                      fontFamily: AppConstants.pianistChatGroup,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppConstants.mediumFontSize16),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _value2 = !_value2;
                                      });

                                      print('asjhdfbgashjbfasf: $_value1');
                                    },
                                    child: _value2 == false
                                        ? const Icon(
                                            Icons.check_box_outline_blank,
                                            size: 25,
                                            color: AppConstants.clrWhite,
                                          )
                                        : const Icon(Icons.check_box_outlined,
                                            size: 25,
                                            color: AppConstants.clrWhite),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    AppConstants.violinistChatGroup,
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontFamily:
                                            AppConstants.pianistChatGroup,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppConstants.mediumFontSize16),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _value3 = !_value3;
                                      });

                                      print('asjhdfbgashjbfasf: $_value1');
                                    },
                                    child: _value3 == false
                                        ? const Icon(
                                            Icons.check_box_outline_blank,
                                            size: 25,
                                            color: AppConstants.clrWhite,
                                          )
                                        : const Icon(Icons.check_box_outlined,
                                            size: 25,
                                            color: AppConstants.clrWhite),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    AppConstants.chatWithJohnDoePrivately,
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontFamily:
                                            AppConstants.pianistChatGroup,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppConstants.mediumFontSize16),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    CustomButton(
                        height: 50,
                        width: AppConstants.displayWidth(context) * 0.8,
                        onTap: () => Navigator.pop(context),
                        padding: const EdgeInsets.all(10),
                        radius: 12,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        text: AppConstants.confirm,
                        textColor: AppConstants.clrWhite,
                        color: AppConstants.clrDialogBtnYesBg,
                        icon: false)
                  ],
                ),
              );
            }));
      });
}

warningDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.warning_image,
                  width: 100,
                  height: 100,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(AppConstants.warning1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w600))),
                const Text(AppConstants.warning2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppConstants.mediumFontSize16,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        color: AppConstants.clrWhite,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          height: 50,
                          width: AppConstants.displayWidth(context) * 0.35,
                          onTap: () => Navigator.pop(context),
                          padding: const EdgeInsets.all(10),
                          radius: 12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15,
                          text: AppConstants.no,
                          textColor: AppConstants.clrWhite,
                          color: AppConstants.clrDialogBtnNoBg,
                          icon: false),
                      CustomButton(
                          height: 50,
                          width: AppConstants.displayWidth(context) * 0.35,
                          onTap: () => Navigator.pop(context),
                          padding: const EdgeInsets.all(10),
                          radius: 12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15,
                          text: AppConstants.yes,
                          textColor: AppConstants.clrWhite,
                          color: AppConstants.clrDialogBtnYesBg,
                          icon: false)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

doneDialog1(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.done_image,
                  width: 100,
                  height: 100,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(AppConstants.doneString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        );
      });
}

chooseOptionDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text.rich(
                  TextSpan(
                      text: 'Your pocket have ',
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize20,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrWhite),
                      children: [
                        TextSpan(
                            text: '2 ',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize20,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrButtonGreen)),
                        TextSpan(
                            text: 'coins.\n',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize20,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrWhite)),
                        TextSpan(
                            text: 'Buy now:',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize20,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrWhite))
                      ]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '100 Coins',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize17,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            ),
                            Text(
                              '100 RMB',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize14,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '600 Coins',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize17,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            ),
                            Text(
                              '500 RMB',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize14,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '1000 Coins',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize17,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            ),
                            Text(
                              '800 RMB',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize14,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '10000 Coins',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize17,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            ),
                            Text(
                              '5000 RMB',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize14,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    height: 50,
                    width: AppConstants.displayWidth(context),
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    radius: 12,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    text: AppConstants.cancel,
                    textColor: AppConstants.clrWhite,
                    color: AppConstants.clrDialogBtnYesBg,
                    icon: false),
              ],
            ),
          ),
        );
      });
}

chargeTokenWarningDialog(BuildContext context) {
  bool _value1 = false;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppConstants.warning_image,
                      height: 80,
                      width: 80,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                        AppConstants.willChargeTokenOnceApplyTheJob,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _value1 = !_value1;
                            });

                            print('asjhdfbgashjbfasf: $_value1');
                          },
                          child: _value1 == false
                              ? const Icon(
                                  Icons.check_box_outline_blank,
                                  size: 25,
                                  color: AppConstants.clrWhite,
                                )
                              : const Icon(Icons.check_box_outlined,
                                  size: 25, color: AppConstants.clrWhite),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          AppConstants.dontAskMeAgain,
                          style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontFamily: AppConstants.pianistChatGroup,
                              fontWeight: FontWeight.w500,
                              fontSize: AppConstants.mediumFontSize16),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                              height: 50,
                              width: AppConstants.displayWidth(context) * 0.35,
                              onTap: () => Navigator.pop(context),
                              padding: const EdgeInsets.all(10),
                              radius: 12,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize15,
                              text: AppConstants.no,
                              textColor: AppConstants.clrWhite,
                              color: AppConstants.clrDialogBtnNoBg,
                              icon: false),
                        ),
                        const SizedBox(width: 10),
                        Expanded(

                          child: CustomButton(
                              height: 50,
                              width: AppConstants.displayWidth(context) * 0.35,
                              onTap: () {
                                Navigator.pop(context);
                                topCoinsDialog(context);
                              },
                              padding: const EdgeInsets.all(10),
                              radius: 12,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize15,
                              text: AppConstants.yes,
                              textColor: AppConstants.clrWhite,
                              color: AppConstants.clrDialogBtnYesBg,
                              icon: false),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      });
}

topCoinsDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        videoRequestDialog(context);
                      },
                      child: Row(
                        children: [
                          Image.asset(AppConstants.goldImage,
                              height: 25, width: 25),
                          const SizedBox(width: 15),
                          const Text(
                            'Top 10 / 10 coins',
                            style: TextStyle(
                                fontSize: AppConstants.mediumFontSize12,
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstants.fontPoppinsRegular),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 15),
                        const Text(
                          'Top 20 / 5 coins',
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize12,
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstants.fontPoppinsRegular),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppConstants.clrDialogBtnNoBg,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 15),
                        const Text(
                          'Apply Now / 2 coins',
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize12,
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstants.fontPoppinsRegular),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    height: 50,
                    width: AppConstants.displayWidth(context),
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    radius: 12,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    text: AppConstants.cancel,
                    textColor: AppConstants.clrWhite,
                    color: AppConstants.clrDialogBtnYesBg,
                    icon: false),
              ],
            ),
          ),
        );
      });
}

List<CameraDescription> cameras = [];

videoRequestDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    AppConstants.whichVideoWouldYouLikeToSubmitToRequester,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppConstants.mediumFontSize16,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        color: AppConstants.clrWhite,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 15),
                CustomButton(
                  width: AppConstants.displayWidth(context),
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyVideoScreen()));
                  },
                  color: AppConstants.clrBtnBlueGradient2,
                  icon: true,
                  text: AppConstants.useApplicantProfileVideo,
                  fontFamily: AppConstants.fontPoppinsRegular,
                  fontSize: AppConstants.mediumFontSize15,
                  image: Image.asset(
                    AppConstants.profile,
                    height: 15,
                    width: 15,
                  ),
                  radius: 12,
                  textColor: AppConstants.clrWhite,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  width: AppConstants.displayWidth(context),
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  onTap: () async {
                    try {
                      WidgetsFlutterBinding.ensureInitialized();
                      cameras = await availableCameras();
                    } on CameraException catch (e) {
                      print('Error in fetching the cameras: $e');
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen('')));

                  },
                  color: AppConstants.clrBtnTeal,
                  icon: true,
                  text: AppConstants.recordLivVideo,
                  fontFamily: AppConstants.fontPoppinsRegular,
                  fontSize: AppConstants.mediumFontSize15,
                  image: Image.asset(
                    AppConstants.video,
                    height: 15,
                    width: 15,
                  ),
                  radius: 12,
                  textColor: AppConstants.clrWhite,
                ),
                const SizedBox(height: 50),
                CustomButton(
                    height: 50,
                    width: AppConstants.displayWidth(context),
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    radius: 12,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    text: AppConstants.cancel,
                    textColor: AppConstants.clrWhite,
                    color: AppConstants.clrDialogBtnYesBg,
                    icon: false),
              ],
            ),
          ),
        );
      });
}

deleteDialog(
  BuildContext context,
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.delete,
                  width: 80,
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                      AppConstants.areYouSureYouWantToDeleteTheSelectedVideos,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize16,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrWhite,
                          fontWeight: FontWeight.w600)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                          height: 50,
                          onTap: () => Navigator.pop(context),
                          padding: const EdgeInsets.all(10),
                          radius: 12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15,
                          text: AppConstants.no,
                          textColor: AppConstants.clrWhite,
                          color: AppConstants.clrDialogBtnNoBg,
                          icon: false),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                          height: 50,
                          onTap: () => Navigator.pop(context),
                          padding: const EdgeInsets.all(10),
                          radius: 12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15,
                          text: AppConstants.yes,
                          textColor: AppConstants.clrWhite,
                          color: AppConstants.clrDialogBtnYesBg,
                          icon: false),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

postVideoDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(AppConstants.whichVideoWouldYouLikeToPost,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppConstants.mediumFontSize16,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        color: AppConstants.clrWhite,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 15),
                CustomButton(
                  width: AppConstants.displayWidth(context),
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  onTap: () {},
                  color: AppConstants.clrBtnBlueGradient2,
                  icon: true,
                  text: AppConstants.uploadVideo,
                  fontFamily: AppConstants.fontPoppinsRegular,
                  fontSize: AppConstants.mediumFontSize15,
                  image: Image.asset(
                    AppConstants.upload,
                    height: 20,
                    width: 20,
                  ),
                  radius: 12,
                  textColor: AppConstants.clrWhite,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  width: AppConstants.displayWidth(context),
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  onTap: () {},
                  color: AppConstants.clrBtnTeal,
                  icon: true,
                  text: AppConstants.recordLivVideo,
                  fontFamily: AppConstants.fontPoppinsRegular,
                  fontSize: AppConstants.mediumFontSize15,
                  image: Image.asset(
                    AppConstants.video,
                    height: 20,
                    width: 20,
                  ),
                  radius: 12,
                  textColor: AppConstants.clrWhite,
                ),
                const SizedBox(height: 50),
                CustomButton(
                    height: 50,
                    width: AppConstants.displayWidth(context),
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    radius: 12,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    text: AppConstants.cancel,
                    textColor: AppConstants.clrWhite,
                    color: AppConstants.clrDialogBtnYesBg,
                    icon: false),
              ],
            ),
          ),
        );
      });
}



donateStartDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppConstants.clrDialogBg,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.db_image,
                  width: 100,
                  height: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(AppConstants.otherMembersCanDonate,
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize16,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrWhite,
                          fontWeight: FontWeight.w400)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppConstants.atleast,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w400)),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.clrLightGreyTxt),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      child: const Center(
                        child: Text(
                          '10',
                          style: TextStyle(
                              color: AppConstants.clrDarkGreyText,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize16),
                        ),
                      ),
                    ),
                    const Text(AppConstants.coinsToChatWithMe,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                CustomButton(
                    height: 50,
                    width: AppConstants.displayWidth(context),
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 50),
                    radius: 12,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    text: AppConstants.start,
                    textColor: AppConstants.clrWhite,
                    color: AppConstants.clrDialogBtnYesBg,
                    icon: false)
              ],
            ),
          ),
        );
      });
}



applicantProfileDialog(BuildContext context) {
  bool isSwitched = true;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: AppConstants.clrDialogBg,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                margin:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppConstants.applicantProfile,
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize20,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w700,
                          color: AppConstants.clrWhite),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicantInfoScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppConstants.clrDialogBtnNoBg,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppConstants.account,
                                  style: TextStyle(
                                      fontSize: AppConstants.mediumFontSize14,
                                      color: AppConstants.clrWhite,
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                      AppConstants.fontPoppinsRegular),
                                ),
                                Text(
                                  AppConstants.youCurrentlyUseAlipayToLogin,
                                  style: TextStyle(
                                      fontSize: AppConstants.mediumFontSize14,
                                      color: AppConstants.clrWhite
                                          .withOpacity(0.5),
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                      AppConstants.fontPoppinsRegular),
                                )
                              ],
                            ),
                            const Icon(Icons.info_outline,
                                color: AppConstants.clrWhite)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.clrDialogBtnNoBg,
                      ),
                      padding:
                      const EdgeInsets.only(top: 5, bottom: 5, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.info_outline,
                                  color: AppConstants.clrWhite, size: 18),
                              SizedBox(width: 10),
                              Text(
                                AppConstants.rememberSignInInfo,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize14,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                    AppConstants.fontPoppinsRegular),
                              )
                            ],
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor:
                            AppConstants.clrSkyBlueTxt.withOpacity(0.25),
                            activeColor: AppConstants.clrSkyBlueTxt,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: (){
                        UserController().signOutGoogle();
                        FacebookAuth.instance.logOut();
                        Shared_Preferences.clearPref(Shared_Preferences.keyApiToken);
                        Shared_Preferences.clearPref(Shared_Preferences.keyUserData);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppConstants.clrDialogBtnNoBg,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              AppConstants.logout,
                              color: AppConstants.clrWhite,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              AppConstants.logOut,
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize14,
                                  color: AppConstants.clrWhite,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppConstants.fontPoppinsRegular),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      });
}




