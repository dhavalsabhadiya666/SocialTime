
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/add_applicant_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/screen/me/apply_record.dart';
import 'package:pinmetar_app/screen/me/me_post_help_details.dart';
import 'package:pinmetar_app/screen/me/my_video.dart';
import 'package:pinmetar_app/screen/me/pocket_screen.dart';
import 'package:pinmetar_app/screen/me/recommend_job_screen.dart';
import 'package:pinmetar_app/screen/me/reject_list_screen.dart';
import 'package:pinmetar_app/screen/me/save_job_screen.dart';
import 'package:pinmetar_app/screen/me/save_list_screen.dart';
import 'package:pinmetar_app/screen/me/setting_screen.dart';
import 'package:pinmetar_app/screen/me/short_list_screen.dart';
import 'package:pinmetar_app/screen/message/chat_page.dart';
import 'package:pinmetar_app/screen/video/camera_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'fill_application_detail.dart';
import 'following_screen.dart';
import 'like_video_screen.dart';

class MeBackendCardScreen extends StatefulWidget {
  const MeBackendCardScreen({Key? key}) : super(key: key);

  @override
  _MeBackendCardScreenState createState() => _MeBackendCardScreenState();
}

class _MeBackendCardScreenState extends StateMVC<MeBackendCardScreen> {
  AddApplicantController? _con;

  _MeBackendCardScreenState() : super(AddApplicantController()) {
    _con = controller as AddApplicantController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getUserProfileApi();
    _con!.getApplicantDetailEditApi();
    _con!.getPostApi(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            //  height: MediaQuery.of(context).size.width * 0.75,
            width: MediaQuery.of(context).size.width ,
            margin: const EdgeInsets.only(top: 15),
            padding:
                const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 15),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppConstants.clrBtnBlueGradient1,
                    AppConstants.clrBtnBlueGradient2
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
                      children: const [
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.keyboard_backspace,
                        //       color: AppConstants.clrWhite,
                        //       size: 25,
                        //     )),
                        // const SizedBox(width: 10),
                        Text(
                          AppConstants.strProfile,
                          style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontSize: AppConstants.mediumFontSize18,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatScreen()));
                            },
                            child: Image.asset(AppConstants.speaker,
                                width: 20, height: 20)),
                        const SizedBox(width: 15),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset(AppConstants.help,
                                width: 20, height: 20)),
                        const SizedBox(width: 15),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingScreen()));
                            },
                            child: const Icon(Icons.settings,
                                color: AppConstants.clrWhite, size: 23)),
                        const SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const MeHelpDetails()));
                      },
                      child: Container(
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
                                    image: NetworkImage(_con!
                                        .getApplicantEditData.profileImage
                                        .toString()),
                                    fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _con!.userProfileData == null || _con!.userProfileData.name ==null
                              ? ''
                              : _con!.userProfileData.name.toString(),
                          style: const TextStyle(
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize24),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FillApplicationDetail(false),
                                ));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                AppConstants.add,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                AppConstants.applyApplicant,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize16,
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    color: AppConstants.clrWhite),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 15, top: 15),
                  decoration: BoxDecoration(
                    color: AppConstants.clrBlack,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset(AppConstants.private_fan,
                                width: 25, height: 25),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    '10.5 K',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontSize: MediaQuery.of(context).size.width *0.040,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular),
                                  ),
                                  Text(
                                    AppConstants.privateFans,
                                    style: TextStyle(
                                        color: AppConstants.clrDarkGreyText,
                                        fontSize: MediaQuery.of(context).size.width *0.03,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset(AppConstants.favorite_red,
                                width: 25, height: 25),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    '34.5 K',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontSize: MediaQuery.of(context).size.width *0.040,
                                        fontFamily: AppConstants.fontPoppinsRegular),
                                  ),
                                  Text(
                                    AppConstants.totalLikes,
                                    style: TextStyle(
                                        color: AppConstants.clrDarkGreyText,
                                        fontSize: MediaQuery.of(context).size.width *0.03,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 08),
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset(AppConstants.goldImage,
                                width: 25, height: 25),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    _con!.getApplicantEditData == null || _con!.getApplicantEditData.balance ==null
                                        ? '' : _con!.getApplicantEditData.balance.toString(),
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontSize: MediaQuery.of(context).size.width *0.040,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular),
                                  ),
                                  Text(
                                    AppConstants.totalCoins,
                                    style: TextStyle(
                                        color: AppConstants.clrDarkGreyText,
                                        fontSize: MediaQuery.of(context).size.width *0.03,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppConstants.clrBlack26)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          postVideoRequestDialog(context);
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => PostVideoScreen()));
                        },
                        child: Column(
                          children: [
                            Image.asset(AppConstants.add,
                                width: 23, height: 23),
                            const SizedBox(height: 10),
                            const Text(
                              AppConstants.postVideo,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 1.5,
                        height: 50,
                        color: AppConstants.clrBlack26),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyVideoScreen(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Image.asset(AppConstants.video,
                                  width: 20, height: 20),
                              const SizedBox(height: 10),
                              const Text(
                                AppConstants.myVideo,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppConstants.clrWhite,
                                    fontFamily:
                                        AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize13),
                              ),
                              const Text(
                                '2.13 k',
                                style: TextStyle(
                                    color: AppConstants.clrDarkGreyText,
                                    fontFamily:
                                        AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 1.5,
                        height: 50,
                        color: AppConstants.clrBlack26),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PocketScreen(_con!.getApplicantEditData.applicantId.toString()),
                              ));
                        },
                        child: Column(
                          children: [
                            Image.asset(AppConstants.wallet,
                                width: 20, height: 20),
                            const SizedBox(height: 10),
                            const Text(
                              AppConstants.pocket,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize13),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppConstants.clrBlack26)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaveJobScreen(),
                              ));
                        },
                        child: Column(
                          children: [
                            Image.asset(AppConstants.work,
                                width: 20, height: 20),
                            const SizedBox(height: 10),
                            const Text(
                              AppConstants.saveJob,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 1.5,
                        height: 50,
                        color: AppConstants.clrBlack26),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecommendJobScreen(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Image.asset(AppConstants.work,
                                  width: 20, height: 20),
                              const SizedBox(height: 10),
                              const Text(
                                AppConstants.recommendJob,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppConstants.clrWhite,
                                    fontFamily:
                                        AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 1.5,
                        height: 50,
                        color: AppConstants.clrBlack26),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApplyRecord()));
                        },
                        child: Column(
                          children: [
                            Image.asset(AppConstants.paper,
                                width: 20, height: 20),
                            const SizedBox(height: 10),
                            const Text(
                              AppConstants.applyRecord,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize13),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppConstants.clrBlack26)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LikeVideoScreen(),
                            ));
                      },
                      child: Column(
                        children: [
                          Image.asset(AppConstants.like_thunmb,
                              width: 20, height: 20),
                          const SizedBox(height: 10),
                          const Text(
                            AppConstants.likeVideo,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize13),
                          ),
                          const Text(
                            '8795',
                            style: TextStyle(
                                color: AppConstants.clrDarkGreyText,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize12),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: 1.5,
                        height: 50,
                        color: AppConstants.clrBlack26),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FollowingScreen(),
                            ));
                      },
                      child: Column(
                        children: [
                          Image.asset(AppConstants.following_image,
                              width: 20, height: 20),
                          const SizedBox(height: 10),
                          const Text(
                            AppConstants.following,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize13),
                          ),
                          const Text(
                            '2.13 k',
                            style: TextStyle(
                                color: AppConstants.clrDarkGreyText,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppConstants.postHelpPreview,
                    style: TextStyle(
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        color: AppConstants.clrWhite,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              _con!.getPostData == null ||  _con!.getPostData.data == null
                  ? Container(
                      height: MediaQuery.of(context).size.width * 0.30,
                      child: const Center(
                          child: Text(
                        'Data Not Found',
                        style: TextStyle(color: AppConstants.clrGreyText),
                      )),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _con!.getPostData.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppConstants.clrLightGreyTxt,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShortListScreen()));
                                },
                                child: Text(
                                    _con!.getPostData.data![i].title.toString(),
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppConstants.clrSkyBlueTxt,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            AppConstants.mediumFontSize13,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular)),
                              ),
                              const SizedBox(height: 8),
                              Text(_con!.getPostData.data![i].time.toString(),
                                  style: const TextStyle(
                                      color: AppConstants.clrWhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppConstants.mediumFontSize13,
                                      fontFamily:
                                          AppConstants.fontPoppinsRegular)),
                              const SizedBox(height: 10),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.45,
                                height: 1,
                                color: AppConstants.clrBlack26,
                              ),
                              const SizedBox(height: 25),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MeHelpDetails(),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(AppConstants.applyListNew,
                                        style: TextStyle(
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.clrWhite)),
                                    Text('10',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppConstants.clrSkyBlueTxt))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(AppConstants.hireNumber,
                                      style: TextStyle(
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular,
                                          fontSize:
                                              AppConstants.mediumFontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: AppConstants.clrWhite)),
                                  Text('0',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline,
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular,
                                          fontSize:
                                              AppConstants.mediumFontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: AppConstants.clrSkyBlueTxt))
                                ],
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShortListScreen(),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(AppConstants.shortList,
                                        style: TextStyle(
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.clrWhite)),
                                    Text('15',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppConstants.clrSkyBlueTxt))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SaveListScreen(),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(AppConstants.saveList,
                                        style: TextStyle(
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.clrWhite)),
                                    Text('30',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppConstants.clrSkyBlueTxt))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RejectListScreen(),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(AppConstants.rejectList,
                                        style: TextStyle(
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.clrWhite)),
                                    Text('15',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: AppConstants
                                                .fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppConstants.clrSkyBlueTxt))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })
            ],
          )
        ],
      ),
    );
  }

  postVideoRequestDialog(BuildContext context) {
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
                      Navigator.pop(context);
                     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyVideoScreen()));
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
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen('PostVideo')));

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
}
