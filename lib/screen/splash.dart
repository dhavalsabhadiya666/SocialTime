import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/screen/home/bottom_navigation_bar.dart';
import 'package:pinmetar_app/screen/login.dart';

import 'job/job_post_help_details.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    String? userToken = await  Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'');
    if(userToken ==null || userToken == ''){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const  LoginScreen()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => CustomBottomNavigationBar(4)));
    }
  }
  @override
  initState() {
    super.initState();
    getDeviceInFo();
    startTime();
  }


  String deviceToken = '';

  getDeviceInFo() async {
    try {
      deviceToken = (await FirebaseMessaging.instance.getToken())!;
      print('deviceToken --> ${deviceToken.toString()}');
      Shared_Preferences.prefSetString(Shared_Preferences.keyDeviceToken, deviceToken.toString());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: Container());
  }
}
