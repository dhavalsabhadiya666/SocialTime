import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/model/applicant_detail_model.dart';
import 'package:pinmetar_app/model/get_post_model.dart';
import 'package:pinmetar_app/model/home_list_model.dart';
import 'package:pinmetar_app/model/review_list_model.dart';
import 'package:pinmetar_app/model/skill_model.dart';
import 'package:pinmetar_app/repository/home_repository.dart' as home;
import 'package:pinmetar_app/repository/add_applicat_repository.dart' as addApplicat;

class HomeController extends ControllerMVC {
  HomeListData homeListDataModel  = HomeListData();
  HomeListData followerListDataModel  = HomeListData();
  ApplicantDetailData applicantDetailData  = ApplicantDetailData();
  ReviewListDataModel reviewListDataModel  = ReviewListDataModel();
  int purchaseCoins =0;
  List<GetSkillData>? getSkillDataModel = [];

  Future<void> getHomeListApi(int page,bool isLoader, {String? search,String? category}) async {
    // FocusScope.of(context).unfocus();
    if(isLoader==true){
      showLoader();
    }

    await home.getHomeListApi(page,search: search,category: category).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            homeListDataModel = value.data!;
          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      if(isLoader==true){
        hideLoader();
      }
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      if(isLoader==true){
        hideLoader();
      }
    });
  }

  Future<void> getFollowersListApi() async {
    // FocusScope.of(context).unfocus();
    showLoader();
    await home.getFollowersListApi().then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            followerListDataModel = value.data!;
          });

        } else {
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

  Future<void> getApplicantDetailApi(String applicantId,bool isLoader) async {
    // FocusScope.of(context).unfocus();
    if(isLoader==true){
      showLoader();
    }
    await home.getApplicantDetailApi(applicantId).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            applicantDetailData = value.data!;
          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      if(isLoader==true){
        hideLoader();
      }
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      if(isLoader==true){
        hideLoader();
      }
    });
  }

  Future<void> likeApplicantApi(String applicantId) async {
    // FocusScope.of(context).unfocus();
   // showLoader();
    await home.likeApplicantApi(applicantId).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            if(value.data!.like==1){
              showToast('Like');
            }else{
              showToast('UnLike');
            }

          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
    //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> addFollowerApi(String applicantId) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await home.addFollowerApi(applicantId).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            if(value.data!.follow==1){
              showToast('Follow');
            }else{
              showToast('Unfollow');
            }

          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> addReviewApi(String applicantId,String megs) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await home.addReviewApi(applicantId,megs).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            showToast(value.message.toString());
          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> getReviewListApi(String applicantId,int page) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await home.getReviewListApi(applicantId,page).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            reviewListDataModel =value.data!;
          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> saveMediaReportApi(String applicantId,String media,String message) async {
    // FocusScope.of(context).unfocus();
    // showLoader();

    print('applicantId  ${applicantId}');
    print('media  ${media}');
    print('message  ${message}');
    await home.saveMediaReportApi(applicantId,media,message).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            showToast(value.message.toString());
          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> donateDialogApi(BuildContext context, String applicantId) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await home.donateApi(applicantId).then((value) {
      if (value != null) {
        if (value.success == 1) {
          Navigator.pop(context);
          purchaseCoins = 1;
          setState(() {
            doneDialog(context);
          });
        } else {
          setState(() {  purchaseCoins = 0;});

          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> purchaseCoinsApi(BuildContext context, String applicantId,int coins) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await home.purchaseCoinsApi(applicantId,coins).then((value) {
      if (value != null) {
        if (value.success == 1) {
          Navigator.pop(context);
          Navigator.pop(context);

          showToast('$coins Coins Purchase Successfully');
          setState(() {
          });
        } else {

          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      //  hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //hideLoader();
    });
  }

  Future<void> getSkillHomeApi() async {
    // FocusScope.of(context).unfocus();
    //showLoader();
    await addApplicat.getSkillApi().then((value) {
      if (value != null) {
        if (value.success == 1) {
          getSkillDataModel = value.data;
          setState(() { });
        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      // hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //  hideLoader();
    });
  }
  Future<void> likeVideoApi(String postVideoId) async {
    // FocusScope.of(context).unfocus();
    //showLoader();
    await addApplicat.likeVideo(postVideoId).then((value) {
      if (value != null) {
        if (value.success == 1) {
          showToast(value.message.toString());
        //  getSkillDataModel = value.data;
          setState(() { });
        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      // hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      //  hideLoader();
    });
  }
}