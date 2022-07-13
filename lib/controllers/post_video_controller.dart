import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/model/post_video_model.dart';
import 'package:pinmetar_app/repository/post_video_repository.dart' as post;
import 'package:pinmetar_app/screen/home/bottom_navigation_bar.dart';

class PostController extends ControllerMVC {
  PostVideoModel postVideoModel = PostVideoModel();

  void postVideoApi(BuildContext context) async {
    showLoader();
    post.postVideoApi(postVideoModel).then((value) {
      if (value != null) {
        if (value.success == 1) {
          // usersData =value.result!;
          showToast(value.message.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomBottomNavigationBar(4)));

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
