import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/home_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/custom_widget/search_widget.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/screen/home/full_video_screen.dart';
import 'package:pinmetar_app/screen/home/home_search.dart';
import 'package:pinmetar_app/utils/constants.dart';

import '../login.dart';
import 'member_profile.dart';

class HomeSearchResultPage extends StatefulWidget {
  @override
  _HomeSearchResultPageState createState() => _HomeSearchResultPageState();
}

class _HomeSearchResultPageState extends StateMVC<HomeSearchResultPage> {
  HomeController? _con;

  _HomeSearchResultPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  int isSelected = 0;
  String selectedCategory = '';
  String? userToken = '';

  List<Color> borderColor = [Colors.red, Colors.yellow, Colors.green];

  TextEditingController searchController  =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUSerApiToken();
    _con!.getSkillHomeApi();
    _con!.getHomeListApi(1, true);
  }

  getUSerApiToken() async {
    await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken, '')
        .then((value) {
      if (value!.isNotEmpty) {
        setState(() {
          userToken = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: searchWidget(
                  hint: 'Search...',
                  fillColor: AppConstants.clrBlack26,
                  controller: searchController,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      AppConstants.search_icon,
                      height: 10,
                      width: 10,
                      color: AppConstants.clrLightGreyTxt,
                    ),
                  ),
                  // onSubmitted: (val) {
                  //   setState(() {
                  //     _con!.getHomeListApi(1, false, search: val.toString());
                  //   });
                  // },
                  onChanged: (val) {
                    print('eiughrtiouerjioyjirtyjio ${val.toString()}');
                    setState(() {
                      _con!.getHomeListApi(1, false, search: val.toString());
                    });
                   }
                   ),
            ),
            Container(
              height: 66,
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _con!.getSkillDataModel!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(
                      margin: const EdgeInsets.only(right: 8),
                      height: 30,
                      width: AppConstants.displayWidth(context) * 0.3,
                      onTap: () {
                        setState(() {
                          selectedCategory = _con!.getSkillDataModel![index].skill.toString();
                        });
                        _con!.getHomeListApi(1,true,category: selectedCategory.toString());

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeSearchResultPage()));
                      },
                      gradient: selectedCategory == _con!.getSkillDataModel![index].skill.toString()
                          ? const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppConstants.clrBtnBlueGradient1,
                          AppConstants.clrBtnBlueGradient2
                        ],
                      )
                          : const LinearGradient(colors: [
                        AppConstants.clrTransparent,
                        AppConstants.clrTransparent,
                      ]),
                      textColor: AppConstants.clrWhite,
                      radius: 10,
                      text: "#${_con!.getSkillDataModel![index].skill.toString()}",
                      fontSize: AppConstants.mediumFontSize11,
                      fontFamily: AppConstants.fontPoppinsRegular,
                      border: Border.all(
                          color: AppConstants.clrGreyText, width: 0.2),
                    );
                  }),
            ),
            _con!.homeListDataModel.data == null || _con!.homeListDataModel.data.toString() == '[]'
                ? Container(
                    height: MediaQuery.of(context).size.width /2,
                    child: const Center(
                        child: Text('Data Not Found',
                            style: TextStyle(color: AppConstants.clrGreyText))),
                  )
                : Expanded(
                    child: StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: _con!.homeListDataModel.data!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          if (userToken!.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullVideoScreen(
                                        applicantId: _con!.homeListDataModel
                                            .data![index].applicantId
                                            .toString())));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: _con!
                            .homeListDataModel
                            .data![index]
                            .profileImage !=null || _con!
                                  .homeListDataModel
                                  .data![index]
                                  .profileImage.toString() != ''?
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: borderColor[index % 3],
                                        width: 2.50),
                                    color: AppConstants.clrWhite,
                                    image: DecorationImage(
                                        image: NetworkImage(_con!
                                            .homeListDataModel
                                            .data![index]
                                            .profileImage
                                            .toString()),
                                        fit: BoxFit.fill)),
                                // child: Image.asset(AppConstants.image, fit: BoxFit.fill,),
                              ):Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MemberProfile(
                                            _con!.homeListDataModel
                                                .data![index].applicantId
                                                .toString()),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        AppConstants.userProfile),
                                                    fit: BoxFit.cover)),
                                            // child: Image.network(
                                            //    _con!.homeListDataModel![index].media.toString(),
                                            //     fit: BoxFit.contain,
                                            //     height: 100),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      _con!.homeListDataModel
                                                          .data![index].name
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                          AppConstants.clrWhite,
                                                          fontSize: AppConstants
                                                              .mediumFontSize12,
                                                          fontFamily: AppConstants
                                                              .fontPoppinsRegular,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  const Text('Online',
                                                      style: TextStyle(
                                                          color:
                                                          AppConstants.clrWhite,
                                                          fontSize: AppConstants
                                                              .mediumFontSize10,
                                                          fontFamily: AppConstants
                                                              .fontPoppinsRegular,
                                                          fontWeight:
                                                          FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        AppConstants.wechat_image_button,
                                        fit: BoxFit.contain,
                                        height: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                  _con!.homeListDataModel.data![index].title
                                      .toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: AppConstants.clrGreyText,
                                      fontFamily:
                                          AppConstants.fontPoppinsRegular,
                                      fontSize: AppConstants.mediumFontSize12)),
                            )
                          ],
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(2, index.isEven ? 3 : 2),
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
