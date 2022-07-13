import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/model/add_application_detail_model.dart';
import 'package:pinmetar_app/model/applicant_edit_model.dart';
import 'package:pinmetar_app/model/application_job_list_model.dart';
import 'package:pinmetar_app/model/get_post_model.dart';
import 'package:pinmetar_app/model/skill_model.dart';
import 'package:pinmetar_app/model/user_profile_model.dart';
import 'package:pinmetar_app/repository/add_applicat_repository.dart' as addApplicat;
import 'package:pinmetar_app/screen/me/applicant_profile_screen.dart';

class AddApplicantController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> formKey;
  AddApplicantDetailsModel addApplicantDetailsModel =
      AddApplicantDetailsModel();
  EditApplicantData getApplicantEditData = EditApplicantData();
  GetPostData getPostData = GetPostData();

  UserProfileData userProfileData =UserProfileData();
  List<ApplicantJobListDataModel>? applicantJobListDataModel = [];
  List<GetSkillData>? getSkillDataModel = [];

  List cvCertificate = [];
  String profilePhoto = '';
  String profileVideo = '';
  String cvCertificateUpdate = '';

  AddApplicantController() {
    formKey = GlobalKey<FormState>();
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void useraddApplicantDetailApi(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoader();
      addApplicat
          .addApplicantDetailsApi(addApplicantDetailsModel, cvCertificate ,profilePhoto,profileVideo)
          .then((value) {
        if (value != null) {
          if (value.success == 1) {
            // usersData =value.result!;
            showToast(value.message.toString());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ApplicantInfoScreen()));
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
  }

  Future<void> getApplicantDetailEditApi() async {
    // FocusScope.of(context).unfocus();
    showLoader();
    await addApplicat.getApplicantDetailsApi().then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            getApplicantEditData = value.data!;
          //  print('gdgkfkgdmfg  ${getApplicantEditData.profileImage}');
          });
          // showToast(value.message.toString());

        } else {
          showToast(value.message.toString());
        }
      } else {}
    }).catchError((e) {
      hideLoader();

      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
  }

  Future<void> getPostApi(bool isLoader,{int? page,String? search,String? location}) async {
    // FocusScope.of(context).unfocus();
  if(isLoader ==true){
  showLoader();
  }

    await addApplicat.getPostApi(page: page,search: search,location: location).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            getPostData = value.data!;
          });
        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      if(isLoader ==true){
        hideLoader();
      }

      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      if(isLoader ==true){
        hideLoader();
      }
    });
  }
  Future<void> getUserProfileApi() async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await addApplicat.getUserProfileApi().then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            userProfileData =value.data!;
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


  Future<void> addJobListApi(int listType,String postId) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await addApplicat.addJobListApi(listType, postId).then((value) {
      if (value != null) {
        if (value.success == 1) {
          showToast(value.message.toString());
          setState(() { });
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


  Future<void> applicantJobListApi(int listType) async {
    // FocusScope.of(context).unfocus();
     showLoader();
    await addApplicat.applicantJobListApi(listType).then((value) {
      if (value != null) {
        if (value.success == 1) {
          applicantJobListDataModel = value.data;
          setState(() { });
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

  Future<void> getSkillApi() async {
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
  Future<void> addOtherSkillApi(String skill) async {
    // FocusScope.of(context).unfocus();
   // showLoader();
    await addApplicat.addOtherSkillApi(skill).then((value) {
      if (value != null) {
        if (value.success == 1) {
          showToast(value.message.toString());
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
