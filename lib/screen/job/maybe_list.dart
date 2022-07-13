import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/add_applicant_controller.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/custom_widget/search_widget.dart';
import 'package:pinmetar_app/utils/constants.dart';

class MaybeListScreen extends StatefulWidget {
  const MaybeListScreen({Key? key}) : super(key: key);

  @override
  _MaybeListScreenState createState() => _MaybeListScreenState();
}

class _MaybeListScreenState extends StateMVC<MaybeListScreen> {
  AddApplicantController? _con;

  _MaybeListScreenState() : super(AddApplicantController()) {
    _con = controller as AddApplicantController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.applicantJobListApi(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        title: const Text(
          AppConstants.maybeList,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              deleteDialog(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.delete,
                color: AppConstants.clrWhite,
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                AppConstants.selectAllList,
                height: 25,
                width: 25,
                color: AppConstants.clrWhite,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: _con!.applicantJobListDataModel == null ||
              _con!.applicantJobListDataModel.toString() == '[]'
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                  child: Text('Data Not Found',
                      style: TextStyle(color: AppConstants.clrGreyText))),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                ListView.builder(
                  itemCount: _con!.applicantJobListDataModel!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                        } else if (index == 1) {
                        } else if (index == 2) {
                        } else if (index == 3) {
                          // donateDialog(context);
                        } else if (index == 4) {
                          warningDialog(context);
                        } else if (index == 5) {
                          deleteDialog(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: AppConstants.clrBlack26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _con!.applicantJobListDataModel![index].media !=
                                    null
                                ? Container(
                                    height: 157,
                                    decoration: _con!.applicantJobListDataModel![index].media!
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
                                                image: NetworkImage(
                                                    _con!.applicantJobListDataModel![index].media
                                                        .toString()),
                                                fit: BoxFit.cover))
                                        : _con!.applicantJobListDataModel![index].thumbnail != null ||
                                                _con!.applicantJobListDataModel![index].thumbnail !=
                                                    '' ||
                                                _con!.applicantJobListDataModel![index].thumbnail
                                                        .toString() !=
                                                    'https://pinmetar.technoproject.in/storage/post/'
                                            ? BoxDecoration(
                                                color: AppConstants.clrBlack26,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    image: NetworkImage(_con!.applicantJobListDataModel![index].thumbnail.toString()),
                                                    fit: BoxFit.cover))
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
                                          _con!
                                              .applicantJobListDataModel![index]
                                              .title
                                              .toString(),
                                          style: const TextStyle(
                                              color: AppConstants.clrWhite,
                                              fontSize: 15,
                                              fontFamily: AppConstants
                                                  .fontPoppinsRegular,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          _con!
                                              .applicantJobListDataModel![index]
                                              .location
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
                                          .format(_con!
                                              .applicantJobListDataModel![index]
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: _con!.applicantJobListDataModel![index].profileImage == null
                                                ?const DecorationImage(
                                                image: AssetImage(
                                                    AppConstants.userProfile),
                                                fit: BoxFit.cover)
                                                : DecorationImage(
                                                image: NetworkImage(
                                                    _con!.applicantJobListDataModel![index].profileImage.toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(_con!.applicantJobListDataModel![index].applicantName.toString(),
                                          style: const TextStyle(
                                              color: AppConstants.clrWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  Image.asset(AppConstants.checkCircle,
                                      height: 25, width: 25)
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
