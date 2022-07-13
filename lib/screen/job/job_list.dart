import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/add_applicant_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dropdown_widget.dart';
import 'package:pinmetar_app/screen/job/job_search.dart';
import 'package:pinmetar_app/screen/job/maybe_list.dart';
import 'package:pinmetar_app/screen/job/not_interested_job.dart';
import 'package:pinmetar_app/utils/constants.dart';

import 'apply_job_list.dart';
import 'job_post_help_details.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends StateMVC<JobListScreen> {
  AddApplicantController? _con;

  _JobListScreenState() : super(AddApplicantController()) {
    _con = controller as AddApplicantController;
  }

  var chosenLocation = "Select Location";
  List<String> locationList = [
    'Select Location',
    'Russia',
    'Antarctica',
    'China',
    'United States'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getPostApi(true,page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        leadingWidth: 0,
        leading: Container(
          padding: EdgeInsets.zero,
        ),
        title: const Text(
          AppConstants.job,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobSearchResult(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                AppConstants.search_icon,
                height: 20,
                width: 20,
                color: AppConstants.clrWhite,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              chooseAnOptionDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                AppConstants.document,
                height: 20,
                width: 20,
                color: AppConstants.clrWhite,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          dropdownWidget(
            hintText: 'Select Location',
            lsit: locationList,
            selectedVal: chosenLocation,
            onChanged1: (value) {
              setState(() {
                chosenLocation = value!;
                print('pref Buying time  ${chosenLocation.toString()}');
                if(chosenLocation !='Select Location'){
                  _con!.getPostApi(false,page: 1,location: chosenLocation.toString());
                }else{
                  _con!.getPostApi(true,page: 1);
                }
                setState(() { });
              });
            },
          ),
          const SizedBox(height: 20),
          _con!.getPostData.data == null ||  _con!.getPostData.data.toString() == '[]'
              ? Container(
                  height: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: Text('Data Not Found',
                          style: TextStyle(color: AppConstants.clrGreyText))),
                )
              : ListView.builder(
                  itemCount: _con!.getPostData.data!.length,
                  shrinkWrap: true,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobHelpDetails(),
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: AppConstants.clrBlack26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _con!.getPostData.data![index].media != null
                                ? Container(
                                    height: 157,
                                    decoration: _con!.getPostData.data![index].media!
                                                .split('.')
                                                .last
                                                .toString()
                                                .toLowerCase() !=
                                            'mp4'
                                        ? BoxDecoration(
                                            color: AppConstants.clrBlack26,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: NetworkImage(_con!
                                                    .getPostData
                                                    .data![index]
                                                    .media
                                                    .toString()),
                                                fit: BoxFit.cover))
                                        : _con!.getPostData.data![index].thumbnail != null ||
                                                _con!.getPostData.data![index].thumbnail !=
                                                    '' ||
                                                _con!.getPostData.data![index]
                                                        .thumbnail
                                                        .toString() !=
                                                    'https://pinmetar.technoproject.in/storage/post/'
                                            ? BoxDecoration(
                                                color: AppConstants.clrBlack26,
                                                borderRadius: BorderRadius.circular(12),
                                                image: DecorationImage(image: NetworkImage(_con!.getPostData.data![index].thumbnail.toString()), fit: BoxFit.cover))
                                            : const BoxDecoration(),
                                  ) : Container(),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          _con!.getPostData.data![index].title
                                              .toString(),
                                          style: const TextStyle(
                                              color: AppConstants.clrWhite,
                                              fontSize: 15,
                                              fontFamily: AppConstants
                                                  .fontPoppinsRegular,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          _con!
                                              .getPostData.data![index].location
                                              .toString(),
                                          style: const TextStyle(
                                              color:
                                                  AppConstants.clrLightGreyTxt,
                                              fontSize: 12,
                                              fontFamily: AppConstants
                                                  .fontPoppinsRegular,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  Text(
                                      DateFormat('dd MMM, yyyy')
                                          .format(_con!.getPostData.data![index]
                                              .createdAt!)
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppConstants.clrLightGreyTxt,
                                          fontSize: 12,
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: _con!.getPostData.data![index].profileImage == null
                                            ?const DecorationImage(
                                            image: AssetImage(
                                                AppConstants.userProfile),
                                            fit: BoxFit.cover)
                                            : DecorationImage(
                                            image: NetworkImage(
                                                _con!.getPostData.data![index].profileImage.toString()),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(width: 15),
                                   Text(_con!.getPostData.data![index].applicantName.toString(),
                                      style: const TextStyle(
                                          color: AppConstants.clrWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  chooseAnOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppConstants.clrDialogBg,
              child: StatefulBuilder(builder: (BuildContext context, _) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          AppConstants.chooseAnOption,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppConstants.clrWhite,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize18),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ApplyJobListScreen(),
                                ));
                          },
                          child: dialogList(AppConstants.applyJobList)),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MaybeListScreen(),
                                ));
                          },
                          child: dialogList(AppConstants.maybeList)),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotInterestedJobScreen()));
                          },
                          child: dialogList(AppConstants.notInterestedJob)),
                      const SizedBox(height: 20),
                      CustomButton(
                          height: 50,
                          width: AppConstants.displayWidth(context) * 0.8,
                          onTap: () => Navigator.pop(context),
                          padding: const EdgeInsets.all(10),
                          radius: 12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15,
                          text: AppConstants.cancel,
                          textColor: AppConstants.clrWhite,
                          color: AppConstants.clrDialogBtnYesBg,
                          icon: false)
                    ],
                  ),
                );
              }));
        });
  }

  Widget dialogList(String str) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppConstants.clrDialogBtnNoBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            str,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppConstants.clrWhite,
                fontFamily: AppConstants.fontPoppinsRegular,
                fontSize: 15),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppConstants.clrLightGreyTxt,
          )
        ],
      ),
    );
  }
}
