import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/utils/constants.dart';

class ConnectListScreen extends StatefulWidget {
  @override
  _ConnectListScreenState createState() => _ConnectListScreenState();
}

class _ConnectListScreenState extends State<ConnectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        elevation: 0,
        title: const Text(
          AppConstants.connectList,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontWeight: FontWeight.w700,
              fontSize: AppConstants.mediumFontSize20,
              fontFamily: AppConstants.fontPoppinsRegular),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              size: 25, color: AppConstants.clrWhite),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(AppConstants.delete,
                height: 22, width: 22, color: AppConstants.clrWhite),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {},
            child: Image.asset(AppConstants.select_list,
                height: 40, width: 40, color: AppConstants.clrWhite),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 20),
              child: Text(
                'Mathematics Tutor',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppConstants.mediumFontSize18,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    color: AppConstants.clrWhite),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total: 10',
                  style: TextStyle(
                      color: AppConstants.clrWhite,
                      fontFamily: AppConstants.fontPoppinsRegular,
                      fontSize: AppConstants.mediumFontSize15,
                      fontWeight: FontWeight.w500),
                ),
                Text.rich(TextSpan(
                    text: '4',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppConstants.mediumFontSize14,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        color: AppConstants.clrWhite),
                    children: [
                      TextSpan(
                          text: '/10',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppConstants.mediumFontSize12,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrDarkGreyText))
                    ]))
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
                padding: EdgeInsets.only(bottom: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.72),
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.47,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.clrBlack26),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.47,
                          width: MediaQuery.of(context).size.width * 0.47,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppConstants.clrBlack26,
                              image: const DecorationImage(
                                  image: AssetImage(AppConstants.temp_image))),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, right: 10),
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppConstants.clrWhite,
                                          width: 2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(AppConstants.play,
                                    width: 50, height: 50),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            AppConstants.userProfile))),
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                'John Deo',
                                style: TextStyle(
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppConstants.mediumFontSize15,
                                    fontFamily:
                                    AppConstants.fontPoppinsRegular),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
