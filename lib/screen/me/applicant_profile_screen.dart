import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/add_applicant_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/image_preview.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/user_model.dart';
import 'package:pinmetar_app/screen/home/bottom_navigation_bar.dart';
import 'package:pinmetar_app/screen/me/application_recommend.dart';
import 'package:pinmetar_app/screen/me/fill_application_detail.dart';
import 'package:pinmetar_app/screen/me/setting_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';

class ApplicantInfoScreen extends StatefulWidget {
  ApplicantInfoScreen();

  @override
  _ApplicantInfoScreenState createState() => _ApplicantInfoScreenState();
}

class _ApplicantInfoScreenState extends StateMVC<ApplicantInfoScreen> {
  AddApplicantController? _con;

  _ApplicantInfoScreenState() : super(AddApplicantController()) {
    _con = controller as AddApplicantController;
  }

  UserDataModel userDataModel = UserDataModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    _con!.getApplicantDetailEditApi();
  }

  Future getUserData() async {
    await Shared_Preferences.prefGetString(Shared_Preferences.keyUserData, "")
        .then((user) {
      if (user != null) {
        userDataModel = UserDataModel.fromJson(jsonDecode(user));
        print("User data --->" + userDataModel.toJson().toString());
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      body: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 10),
            padding:
                const EdgeInsets.only(top: 25, left: 10, right: 15, bottom: 15),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppConstants.clrBtnBlueGradient2,
                    AppConstants.clrBtnBlueGradient1,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          AppConstants.applicantProfile,
                          style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontSize: AppConstants.mediumFontSize18,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          print('gfdfg');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FillApplicationDetail(true),
                              ));
                        },
                        child: Image.asset(AppConstants.editImage,
                            width: 20, height: 20))
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppConstants.clrWhite),
                          image: _con!.getApplicantEditData == null ||
                              _con!.getApplicantEditData.profileImage == null ||
                              _con!.getApplicantEditData.profileImage == ''
                              ? const DecorationImage(
                                  image: AssetImage(AppConstants.userProfile),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                      _con!.getApplicantEditData.profileImage.toString()),
                                  fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userDataModel.name == null || userDataModel.name == ''
                              ? ''
                              : userDataModel.name.toString(),
                          style: const TextStyle(
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize20),
                        ),
                        Text(
                          userDataModel.isActive == 1
                              ? 'Available'
                              : 'UnAvailable',
                          style: const TextStyle(
                              fontSize: AppConstants.mediumFontSize16,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrWhite),
                        ),
                        Text(
                          _con!.getApplicantEditData == null || _con!.getApplicantEditData.mobile ==null ||_con!.getApplicantEditData.mobile ==''
                              ? ''
                              : _con!.getApplicantEditData.mobile.toString(),
                          style: const TextStyle(
                              fontSize: AppConstants.mediumFontSize15,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrWhite),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          _con!.getApplicantEditData == null
              ? Container()
              : Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.gradient_person,
                              width: 20, height: 20),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppConstants.actualName,
                                style: TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize15,
                                    color: AppConstants.clrWhite),
                              ),
                              Text(
                                _con!.getApplicantEditData.name == null
                                    ? '-'
                                    : _con!.getApplicantEditData.name
                                        .toString(),
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize16,
                                    color: AppConstants.clrDarkGreyText),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppConstants.clrWhite,
                      ),
                      Row(
                        children: [
                          Image.asset(AppConstants.gradient_title,
                              width: 20, height: 20),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppConstants.title,
                                style: TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize15,
                                    color: AppConstants.clrWhite),
                              ),
                              Text(
                                _con!.getApplicantEditData.title == null
                                    ? '-'
                                    : _con!.getApplicantEditData.title
                                        .toString(),
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize16,
                                    color: AppConstants.clrDarkGreyText),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppConstants.clrWhite,
                      ),
                      Row(
                        children: [
                          Image.asset(AppConstants.gradient_date,
                              width: 20, height: 20),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppConstants.birthday,
                                style: TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize15,
                                    color: AppConstants.clrWhite),
                              ),
                              Text(
                                _con!.getApplicantEditData.dob == null
                                    ? "-"
                                    : _con!.getApplicantEditData.dob.toString(),
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize16,
                                    color: AppConstants.clrDarkGreyText),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppConstants.clrWhite,
                      ),
                      Row(
                        children: [
                          Image.asset(AppConstants.gradient_location,
                              width: 20, height: 20),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppConstants.location,
                                style: TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize15,
                                    color: AppConstants.clrWhite),
                              ),
                              Text(
                                _con!.getApplicantEditData.location == null
                                    ? '-'
                                    : _con!.getApplicantEditData.location
                                        .toString(),
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize16,
                                    color: AppConstants.clrDarkGreyText),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppConstants.clrWhite,
                      ),
                      Row(
                        children: [
                          Image.asset(AppConstants.gradient_skill,
                              width: 20, height: 20),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppConstants.skill,
                                style: TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize15,
                                    color: AppConstants.clrWhite),
                              ),
                              Text(
                                _con!.getApplicantEditData.skill == null
                                    ? '-'
                                    : _con!.getApplicantEditData.skill
                                        .toString(),
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize16,
                                    color: AppConstants.clrDarkGreyText),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppConstants.clrWhite,
                      ),
                      Row(
                        children: [
                          Image.asset(AppConstants.gradient_cv,
                              width: 20, height: 20),
                          const SizedBox(width: 15),
                          const Text(
                            AppConstants.cVCertificate,
                            style: TextStyle(
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15,
                                color: AppConstants.clrWhite),
                          ),
                        ],
                      ),
                      _con!.getApplicantEditData == null ||
                          _con!.getApplicantEditData.cvCertificate
                              .toString() ==
                              '[]'
                          ? const Text(
                        '-',
                        style: TextStyle(
                            fontFamily:
                            AppConstants.fontPoppinsRegular,
                            fontSize:
                            AppConstants.mediumFontSize16,
                            color: AppConstants.clrDarkGreyText),
                      )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                        height:
                        AppConstants.displayWidth(context) *
                              0.2,

                        child:_con!.getApplicantEditData.cvCertificate==null?Container():
                        ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _con!.getApplicantEditData
                                  .cvCertificate!.length,
                              physics:
                              const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int i) {

                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePreview(_con!.getApplicantEditData.cvCertificate![i])));
                                  },
                                  child: Container(
                                    width: AppConstants.displayWidth(
                                        context) *
                                        0.2,
                                    height: AppConstants.displayWidth(
                                        context) *
                                        0.2,
                                    margin: const EdgeInsets.only(
                                        right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        image: _con!.getApplicantEditData.cvCertificate![i].toString().split('.').last == 'png' ||
                                            _con!.getApplicantEditData.cvCertificate![i].toString().split('.').last ==
                                                'PNG' ||
                                            _con!.getApplicantEditData.cvCertificate![i]
                                                .toString()
                                                .split('.')
                                                .last ==
                                                'jpg' ||
                                            _con!.getApplicantEditData.cvCertificate![i]
                                                .toString()
                                                .split('.')
                                                .last ==
                                                'JPG' ||
                                            _con!.getApplicantEditData.cvCertificate![i]
                                                .toString()
                                                .split('.')
                                                .last ==
                                                'jpeg' ||
                                            _con!.getApplicantEditData.cvCertificate![i]
                                                .toString()
                                                .split('.')
                                                .last ==
                                                'JPEG'
                                            ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(_con!
                                                .getApplicantEditData
                                                .cvCertificate![i]
                                                .toString()))
                                            : const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(AppConstants.file_icon))),
                                  ),
                                );
                              }),
                      ),
                          ),
                      const Divider(
                        color: AppConstants.clrWhite,
                      ),
                      //           Container(
                      //             height: 80,
                      //             width: 80,
                      //             decoration:
                      // _con!.getApplicantEditData.cvCertificate!.split('.').last.toString() == 'png' || _con!.getApplicantEditData.cvCertificate!.split('.').last.toString() == 'jepg'||_con!.getApplicantEditData.cvCertificate!.split('.').last.toString() == 'jpg'?
                      //             BoxDecoration(image: DecorationImage(image: NetworkImage(_con!.getApplicantEditData.cvCertificate.toString())))
                      //     : const BoxDecoration(image: DecorationImage(image: AssetImage(AppConstants.icFile)))
                      //
                      //           )
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    margin: const EdgeInsets.only(right: 8, left: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: 40,
                    //width: AppConstants.displayWidth(context) * 0.45,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FillApplicationDetail(true),
                          ));
                    },
                    textColor: AppConstants.clrWhite,
                    radius: 10,
                    color: AppConstants.clrBlack26,
                    text: AppConstants.edit,
                    fontSize: AppConstants.mediumFontSize15,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: 40,
                    //  width: AppConstants.displayWidth(context) * 0.45,
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomBottomNavigationBar(0),
                          ));
                    },
                    textColor: AppConstants.clrWhite,
                    radius: 10,
                    color: AppConstants.clrDialogBtnYesBg,
                    text: AppConstants.confirmApply,
                    fontSize: AppConstants.mediumFontSize15,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
