import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';

class SaveJobScreen extends StatefulWidget {
  @override
  _SaveJobScreenState createState() => _SaveJobScreenState();
}

class _SaveJobScreenState extends State<SaveJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        elevation: 0,
        title: const Text(
          AppConstants.saveJob,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontWeight: FontWeight.w700,
              fontSize: AppConstants.mediumFontSize20,
              fontFamily: AppConstants.fontPoppinsRegular),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              size: 25, color: AppConstants.clrWhite),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: AppConstants.displayWidth(context),
              decoration: BoxDecoration(
                color: AppConstants.clrBlack26,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Product Designer',
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '15 Oct, 2021',
                        style: TextStyle(
                            color: AppConstants.clrDarkGreyText,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize12,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const Text(
                    'Tokopedia',
                    style: TextStyle(
                        color: AppConstants.clrDarkGreyText,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize12,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(AppConstants.userProfile))),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Requseter name',
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize12,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: AppConstants.displayWidth(context),
                    decoration: BoxDecoration(
                      color: AppConstants.clrBlack26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: AppConstants.displayWidth(context) * 0.4,
                          width: AppConstants.displayWidth(context),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12)),
                              image: DecorationImage(
                                  image: AssetImage(AppConstants.temp_job),
                                  fit: BoxFit.cover)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Product Designer',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular,
                                        fontSize:
                                            AppConstants.mediumFontSize14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '15 Oct, 2021',
                                    style: TextStyle(
                                        color: AppConstants.clrDarkGreyText,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular,
                                        fontSize:
                                            AppConstants.mediumFontSize12,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              const Text(
                                'Tokopedia',
                                style: TextStyle(
                                    color: AppConstants.clrDarkGreyText,
                                    fontFamily:
                                        AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize12,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AppConstants.userProfile))),
                                  ),
                                  const SizedBox(width: 15),
                                  const Text(
                                    'Requseter name',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontFamily:
                                            AppConstants.fontPoppinsRegular,
                                        fontSize:
                                            AppConstants.mediumFontSize12,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
