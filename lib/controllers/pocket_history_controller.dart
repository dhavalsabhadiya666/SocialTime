import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/model/pocket_history_model.dart';
import 'package:pinmetar_app/repository/pocket_history_repository.dart' as ph;
import 'package:pinmetar_app/repository/home_repository.dart' as home;

class PocketHistoryController extends ControllerMVC{


  PocketHistoryData? pocketHistoryDataModel = PocketHistoryData();

  Future<void> getPocketHistoryApi(int page,bool isLoader) async {
    // FocusScope.of(context).unfocus();
    if(isLoader==true){
      showLoader();
    }
    await ph.pocketHistory(page).then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            pocketHistoryDataModel = value.data!;
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

  Future<void> purchaseCoinsApi(BuildContext context, String applicantId,int coins) async {
    // FocusScope.of(context).unfocus();
    // showLoader();
    await home.purchaseCoinsApi(applicantId,coins).then((value) {
      if (value != null) {
        if (value.success == 1) {
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

}