
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'circular_loading_widget.dart';
import 'package:bot_toast/bot_toast.dart';

commonAlertNotification(String title, {String? message}) {
  BotToast.showSimpleNotification(title: title, subTitle: message,backgroundColor: Colors.red.shade500);
}

commonAlertNotificationOnlyTitle(String title) {
  BotToast.showSimpleNotification(title: title,backgroundColor: Colors.red.shade500);
}

showLoader() {
  BotToast.showLoading();
}

hideLoader() {
  BotToast.closeAllLoading();
}

//Loader widget
OverlayEntry overlayLoader() {
  OverlayEntry loader = OverlayEntry(builder: (context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      height: size.height,
      width: size.width,
      top: 0,
      left: 0,
      child: Material(
        color: Colors.transparent,
        child: CircularLoadingWidget(
          height: 200,
        ),
      ),
    );
  });
  return loader;
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppConstants.clrPrimary,
      textColor: Colors.white,
      fontSize: 16.0);
}
