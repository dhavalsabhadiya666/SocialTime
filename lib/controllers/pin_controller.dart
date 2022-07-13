import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/model/post_fill_in_model.dart';
import 'package:pinmetar_app/repository/pin_repository.dart' as pin;
import 'package:pinmetar_app/screen/home/bottom_navigation_bar.dart';


PostFillInModel postFillInPassModel = PostFillInModel();

class PinController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> formKey;

  AddApplicantController() {
    formKey = GlobalKey<FormState>();
    this.scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void postFillInApi(BuildContext context) async {
    FocusScope.of(context).unfocus();

    showLoader();
    pin.postFillIn(postFillInPassModel).then((value) {
      if (value != null) {
        if (value.success == 1) {
          // usersData =value.result!;
          showToast(value.message.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomBottomNavigationBar(1)));
          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicantInfoScreen()));
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
