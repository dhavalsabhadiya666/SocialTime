import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/setting_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/custom_widget/textfield_widget.dart';
import 'package:pinmetar_app/utils/constants.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends StateMVC<SettingScreen> {
  SettingController? _con;

  _SettingScreenState() : super(SettingController()) {
    _con = controller as SettingController;
  }

  String selectedAccountAndSecurityRadioBtn = '1';
  bool isSwitched = true;
  int isNotification =0;
  TextEditingController coinsTOBecomeMyFansController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getUserProfileApi(true).then((value) {
      selectedAccountAndSecurityRadioBtn = _con!.userProfileData.security.toString();
      isNotification = _con!.userProfileData.sendNotification!;
      if(_con!.userProfileData.sendNotification ==1){
        isSwitched = true;
      }else{
        isSwitched = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            width: MediaQuery
                .of(context)
                .size
                .width,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    AppConstants.clrBtnBlueGradient1,
                    AppConstants.clrBtnBlueGradient2
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppConstants.clrWhite,
                          size: 25,
                        )),
                    const SizedBox(width: 10),
                    const Text(
                      AppConstants.setting,
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.mediumFontSize18,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppConstants.clrWhite),
                          image: _con!.userProfileData == null ||
                              _con!.userProfileData.profile == null ||
                              _con!.userProfileData.profile == ''
                              ? const DecorationImage(
                              image: AssetImage(AppConstants.userProfile),
                              fit: BoxFit.cover)
                              : DecorationImage(
                              image: NetworkImage(
                                  _con!.userProfileData.profile.toString()),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _con!.userProfileData.name.toString(),
                          style: const TextStyle(
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize24),
                        ),
                        Text(
                          _con!.userProfileData.email.toString(),
                          style: const TextStyle(
                              fontSize: AppConstants.mediumFontSize16,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrWhite),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              children: [
                const Text(AppConstants.userSettings,
                    style: TextStyle(
                        color: AppConstants.clrWhite,
                        fontSize: AppConstants.mediumFontSize16,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 15),
                GestureDetector(
                  child: GestureDetector(
                    onTap: () {
                      coinToBecomeDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppConstants.coin,
                                width: 20, height: 20),
                            const SizedBox(width: 10),
                            const Text(
                              AppConstants.coinsToBecomeMyFans,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize15,
                                  color: AppConstants.clrWhite),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8, left: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppConstants.clrLightBorder)),
                          child: Text(
                          _con!.userProfileData.coinsToBecomeFriend ==null?'': _con!.userProfileData.coinsToBecomeFriend
                                .toString(),
                            style: const TextStyle(
                                color: AppConstants.clrLightTODarkGrey,
                                fontSize: AppConstants.mediumFontSize16,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  color: AppConstants.clrWhite,
                  height: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    applicantProfileDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.ap, width: 20, height: 20),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.applicantProfile,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            applicantProfileDialog(context);
                          },
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: AppConstants.clrLightGreyTxt, size: 30))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  color: AppConstants.clrWhite,
                  height: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    accountAndSecurityDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.security,
                              width: 20, height: 20),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.accountAndSecurity,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: AppConstants.clrLightGreyTxt, size: 30))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8, top: 8),
                  color: AppConstants.clrWhite,
                  height: 0.5,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.ps, width: 20, height: 20),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.privacySetting,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: AppConstants.clrLightGreyTxt, size: 30))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8, top: 8),
                  color: AppConstants.clrWhite,
                  height: 0.2,
                ),
                const SizedBox(height: 15),
                const Text(AppConstants.legal,
                    style: TextStyle(
                        color: AppConstants.clrWhite,
                        fontSize: AppConstants.mediumFontSize16,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.security,
                              width: 20, height: 20),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.privacyPolicy,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: AppConstants.clrLightGreyTxt, size: 30))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  color: AppConstants.clrWhite,
                  height: 0.5,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.useraggrement,
                              width: 20, height: 20),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.userAgreement,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: AppConstants.clrLightGreyTxt, size: 30))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  color: AppConstants.clrWhite,
                  height: 0.5,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.ts, width: 20, height: 20),
                          const SizedBox(width: 10),
                          const Text(
                            AppConstants.termsOfService,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right_sharp,
                              color: AppConstants.clrLightGreyTxt, size: 30))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  accountAndSecurityDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: StatefulBuilder(
              builder: (BuildContext context, stateSetter1) {
                return Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppConstants.accountAndSecurity,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize20,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.clrWhite),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        AppConstants.whoCanViewThisVideo,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            color: AppConstants.clrWhite,
                            fontFamily: AppConstants.fontPoppinsRegular),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppConstants.clrRadioOffBtn,
                            disabledColor: AppConstants.clrRadioOffBtn),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: selectedAccountAndSecurityRadioBtn,
                          title: Text(AppConstants.all,
                              style: TextStyle(
                                  color: selectedAccountAndSecurityRadioBtn ==
                                      "1"
                                      ? AppConstants.clrSkyBlueTxt
                                      : AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize16,
                                  fontFamily: AppConstants.fontPoppinsRegular)),
                          value: '1',
                          activeColor: AppConstants.clrSkyBlueTxt,
                          onChanged: (val) {
                            stateSetter1(() {
                              selectedAccountAndSecurityRadioBtn =
                                  val.toString();
                            });
                          },
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppConstants.clrRadioOffBtn,
                            disabledColor: AppConstants.clrRadioOffBtn),
                        child: RadioListTile(
                          groupValue: selectedAccountAndSecurityRadioBtn,
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppConstants.clrSkyBlueTxt,
                          title: Text(AppConstants.mutualFollowing,
                              style: TextStyle(
                                  color: selectedAccountAndSecurityRadioBtn ==
                                      "2"
                                      ? AppConstants.clrSkyBlueTxt
                                      : AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize16,
                                  fontFamily: AppConstants.fontPoppinsRegular)),
                          value: '2',
                          onChanged: (val) {
                            stateSetter1(() {
                              selectedAccountAndSecurityRadioBtn =
                                  val.toString();
                            });
                          },
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppConstants.clrRadioOffBtn,
                            disabledColor: AppConstants.clrRadioOffBtn),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: selectedAccountAndSecurityRadioBtn,
                          title: Text(AppConstants.onlyMyself,
                              style: TextStyle(
                                  color: selectedAccountAndSecurityRadioBtn ==
                                      "3"
                                      ? AppConstants.clrSkyBlueTxt
                                      : AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize16,
                                  fontFamily: AppConstants.fontPoppinsRegular)),
                          value: '3',
                          activeColor: AppConstants.clrSkyBlueTxt,
                          onChanged: (val) {
                            stateSetter1(() {
                              selectedAccountAndSecurityRadioBtn =
                                  val.toString();
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppConstants.clrDialogBtnNoBg,
                        ),
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5, left: 15),
                        margin: const EdgeInsets.symmetric(vertical: 10),
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
                                  AppConstants.notification,
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
                                stateSetter1(() {
                                  isSwitched = value;
                                  if(isSwitched==true){
                                    isNotification =1;
                                  }else{
                                    isNotification =0;
                                  }
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
                      Center(
                        child: CustomButton(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          width: AppConstants.displayWidth(context) * 0.35,
                          onTap: () {
                            Navigator.pop(context);
                            _con!.saveSettingsApi(security:int.parse(selectedAccountAndSecurityRadioBtn.toString()),sendNotification: isNotification).then((value) {
                              _con!.getUserProfileApi(false);
                            });
                          },
                          textColor: AppConstants.clrWhite,
                          radius: 10,
                          color: AppConstants.clrDialogBtnYesBg,
                          text: AppConstants.save,
                          fontSize: AppConstants.mediumFontSize17,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w600,
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

  coinToBecomeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: StatefulBuilder(
              builder: (BuildContext context, stateSetter1) {
                return Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Text(
                          'Add Coins To Become My Fans',
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize15,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.clrWhite),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 15),
                      textFieldWidget(
                        hint: 'Enter Coins',
                        controller: coinsTOBecomeMyFansController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            AppConstants.coin,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: AppConstants.displayWidth(context) * 0.45,
                        onTap: () {
                          Navigator.pop(context);
                          _con!.saveSettingsApi(
                              coinsToBecomeFriend: coinsTOBecomeMyFansController
                                  .text.toString()).then((value) {
                            _con!.getUserProfileApi(false);
                          });
                        },
                        textColor: AppConstants.clrWhite,
                        radius: 10,
                        color: AppConstants.clrDialogBtnYesBg,
                        text: AppConstants.save,
                        fontSize: AppConstants.mediumFontSize17,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontWeight: FontWeight.w600,
                      ),

                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
