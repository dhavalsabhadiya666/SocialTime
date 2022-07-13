import 'package:flutter/material.dart';
import 'package:pinmetar_app/screen/job/job_post_help_details.dart';
import 'package:pinmetar_app/screen/me/me_post_help_details.dart';
import 'package:pinmetar_app/utils/constants.dart';

class ApplyRecord extends StatefulWidget {
  @override
  _ApplyRecordState createState() => _ApplyRecordState();
}

class _ApplyRecordState extends State<ApplyRecord> {
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
        title:  Text(AppConstants.applyRecord,
            style: const TextStyle(
                fontSize: AppConstants.mediumFontSize20,
                fontFamily: AppConstants.fontPoppinsRegular,
                color: AppConstants.clrWhite,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => JobHelpDetails(),));

              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppConstants.clrBlack26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fulltime',
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize15)),
                    Row(
                      children: [
                        const Text('Application Status: ',
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize10)),
                        Text(index.isOdd ? 'Already read 10 days' : 'UnRead',
                            style: TextStyle(
                                color: index.isOdd ? AppConstants.clrButtonGreen : AppConstants.clrRed,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize12)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            AssetImage(AppConstants.userProfile))),
                              ),
                              const SizedBox(width: 10),
                              const Text('Requester name',
                                  style: TextStyle(
                                      color: AppConstants.clrWhite,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppConstants.fontPoppinsRegular,
                                      fontSize: AppConstants.mediumFontSize12)),
                            ],
                          ),
                          const Text('15 OCt, 2021',
                              style: TextStyle(
                                  color: AppConstants.clrDarkGreyText,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
