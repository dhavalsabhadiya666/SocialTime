import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/screen/home/home_page.dart';
import 'package:pinmetar_app/screen/job/job_list.dart';
import 'package:pinmetar_app/screen/login.dart';
import 'package:pinmetar_app/screen/home/member_profile.dart';
import 'package:pinmetar_app/screen/me/me_profile.dart';
import 'package:pinmetar_app/screen/pin/fill_in_screen.dart';
import 'package:pinmetar_app/screen/register.dart';
import 'package:pinmetar_app/utils/constants.dart';

import '../message/message_home.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  int selectedIndex ;
   CustomBottomNavigationBar(this.selectedIndex,{Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  String? userToken = '';

  static List<Widget> widgetOptions = <Widget>[
    HomePage(),
    const JobListScreen(),
    FillInScreen(),
    const MessageHomeScreen(),
    const MeBackendCardScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex =widget.selectedIndex;
    getUSerApiToken();
  }

  getUSerApiToken() async {
  await Shared_Preferences.prefGetString(Shared_Preferences.keyApiToken,'').then((value) {
   if(value!.isNotEmpty){
     setState(() {
       userToken = value;
     });
   }
 });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async => await SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        bottomNavigationBar: Container(
          color: AppConstants.clrBlack,
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppConstants.home_icon,
                        height: 25,
                        width: 25,
                        color: _selectedIndex == 0
                            ? AppConstants.clrWhite
                            : AppConstants.clrLightGreyTxt,
                      ),
                      Text(
                        AppConstants.home,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: _selectedIndex == 0
                                ? AppConstants.clrWhite
                                : AppConstants.clrLightGreyTxt),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if(userToken!.isNotEmpty){
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }else{
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppConstants.like_icon,
                        width: 25,
                        height: 25,
                        color: _selectedIndex == 1
                            ? AppConstants.clrWhite
                            : AppConstants.clrLightGreyTxt,
                      ),
                      Text(
                        AppConstants.job,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: _selectedIndex == 1
                                ? AppConstants.clrWhite
                                : AppConstants.clrLightGreyTxt),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {

                      if(userToken!.isNotEmpty){
                        setState(() {
                          _selectedIndex = 2;
                        });
                      }else{
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }
                    },
                    child:
                        Image.asset(AppConstants.pin_icon, height: 50, width: 50)),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if(userToken!.isNotEmpty){
                      setState(() {
                        _selectedIndex = 3;
                      });
                    }else{
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppConstants.message_icon,
                        width: 25,
                        height: 25,
                        color: _selectedIndex == 3
                            ? AppConstants.clrWhite
                            : AppConstants.clrLightGreyTxt,
                      ),
                      Text(
                        AppConstants.messages,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: _selectedIndex == 3
                                ? AppConstants.clrWhite
                                : AppConstants.clrLightGreyTxt),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                      if(userToken!.isNotEmpty){
                        setState(() {
                          _selectedIndex = 4;
                        });
                      }else{
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }


                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppConstants.person_icon,
                        height: 25,
                        width: 25,
                        color: _selectedIndex == 4
                            ? AppConstants.clrWhite
                            : AppConstants.clrLightGreyTxt,
                      ),
                      Text(
                        AppConstants.me,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: _selectedIndex == 4
                                ? AppConstants.clrWhite
                                : AppConstants.clrLightGreyTxt),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
