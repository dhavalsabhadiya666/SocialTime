import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.clrWhite,
            size: 25,
          ),
        ),
        title: const Text(
          AppConstants.following,
          style: TextStyle(
              fontSize: AppConstants.mediumFontSize20,
              fontFamily: AppConstants.fontPoppinsRegular,
              color: AppConstants.clrWhite,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppConstants.clrBlack26),
                child: Column(
                  children: [
                    Image.asset(AppConstants.userProfile,
                        width: 120, height: 120),
                    const SizedBox(height: 20),
                    const Text(
                      'Kingston',
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.mediumFontSize15,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Image.asset(AppConstants.goldImage,
                            height: 25, width: 25),
                        const SizedBox(width: 8),
                        const Text(
                          '100 Coins Donate',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize14,
                              color: AppConstants.clrWhite),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
