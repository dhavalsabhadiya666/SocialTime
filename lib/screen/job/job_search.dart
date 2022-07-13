import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/add_applicant_controller.dart';
import 'package:pinmetar_app/custom_widget/search_widget.dart';
import 'package:pinmetar_app/screen/job/job_post_help_details.dart';
import 'package:pinmetar_app/utils/constants.dart';

class JobSearchResult extends StatefulWidget {
  const JobSearchResult({Key? key}) : super(key: key);

  @override
  _JobSearchResultState createState() => _JobSearchResultState();
}

class _JobSearchResultState extends StateMVC<JobSearchResult> {
  AddApplicantController? _con;

  _JobSearchResultState() : super(AddApplicantController()) {
    _con = controller as AddApplicantController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getPostApi(true, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        title: const Text(
          AppConstants.searchResult,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          searchWidget(
              hint: AppConstants.productDesigner,
              fillColor: AppConstants.clrBlack26,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  AppConstants.search_icon,
                  height: 10,
                  width: 10,
                  color: AppConstants.clrLightGreyTxt,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _con!.getPostApi(false, page: 1,search: val.toString());
                });
              }),
          const SizedBox(height: 20),
          _con!.getPostData.data == null || _con!.getPostData.data.toString() == '[]'
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
                                  )
                                : Container(),
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
}
