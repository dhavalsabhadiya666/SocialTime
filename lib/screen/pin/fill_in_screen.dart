import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/controllers/pin_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/screen/pin/location_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';

class FillInScreen extends StatefulWidget {
  @override
  _FillInScreenState createState() => _FillInScreenState();
}

class _FillInScreenState extends StateMVC<FillInScreen> {
  PinController? _con;

  _FillInScreenState() : super(PinController()) {
    _con = controller as PinController;
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<File> selectedFiles = [];
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String? _hour, _minute, _time;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppConstants.postFillIn,
                style: TextStyle(
                    color: AppConstants.clrWhite,
                    fontSize: AppConstants.mediumFontSize20,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                AppConstants.step1Of3PostFillIn,
                style: TextStyle(
                    color: AppConstants.clrWhite,
                    fontSize: AppConstants.mediumFontSize15,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppConstants.clrButtonGreen),
                      child: const Center(
                        child: Text('1',
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize20,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 2,
                        // width: MediaQuery.of(context).size.width * 0.3,
                        decoration: const BoxDecoration(
                            color: AppConstants.clrButtonGreen),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppConstants.clrLightGreyTxt),
                          color: AppConstants.clrBlack),
                      child: const Center(
                        child: Text('2',
                            style: TextStyle(
                                color: AppConstants.clrLightGreyTxt,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize20,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 2,
                        // width: MediaQuery.of(context).size.width * 0.3,
                        decoration: const BoxDecoration(
                            color: AppConstants.clrLightGreyTxt),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppConstants.clrLightGreyTxt),
                          color: AppConstants.clrBlack),
                      child: const Center(
                        child: Text('3',
                            style: TextStyle(
                                color: AppConstants.clrLightGreyTxt,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize20,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    padding: const EdgeInsets.only(
                        top: 30, right: 10, left: 10, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppConstants.clrLightYellow,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppConstants.postHelp,
                          style: TextStyle(
                              color: AppConstants.clrBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: AppConstants.mediumFontSize24,
                              fontFamily: AppConstants.fontKalamRegular),
                        ),
                        const Divider(
                            color: AppConstants.clrDivider, thickness: 1),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            labelText: 'Title',
                            labelStyle: const TextStyle(
                                fontSize: AppConstants.mediumFontSize16,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrDarkGreyText),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            // final TimeOfDay? picked = await showTimePicker(
                            //   context: context,
                            //   initialTime: selectedTime,
                            // );
                            // if (picked != null) {
                            //   setState(() {
                            //     selectedTime = picked;
                            //     selectedTime = picked;
                            //     _hour = selectedTime.hour.toString();
                            //     _minute = selectedTime.minute.toString();
                            //     _time = _hour! + ' : ' + _minute!;
                            //     timeController.text = _time!;
                            //     timeController.text = formatDate(
                            //         DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
                            //         [hh, ':', nn, " ", am]).toString();
                            //   });
                            // }


                          },
                          child: TextFormField(
                            controller: timeController,
                           // enabled: false,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                              //  enabled: false,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppConstants.clrDarkGreyText)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppConstants.clrDarkGreyText)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppConstants.clrDarkGreyText)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppConstants.clrDarkGreyText)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppConstants.clrDarkGreyText)),
                                labelText: 'Time',
                                labelStyle: const TextStyle(
                                    fontSize: AppConstants.mediumFontSize16,
                                    fontFamily:
                                        AppConstants.fontPoppinsRegular,
                                    color: AppConstants.clrDarkGreyText),
                              /*  suffixIcon: const Icon(
                                    Icons.watch_later_outlined,
                                    color: AppConstants.clrDarkGreyText)*/),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: commentController,
                          maxLines: 5,
                          maxLength: 200,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppConstants.clrDarkGreyText)),
                            labelText: 'Comment',
                            labelStyle: const TextStyle(
                                fontSize: AppConstants.mediumFontSize16,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                color: AppConstants.clrDarkGreyText),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Image.asset(AppConstants.redPin,
                          width: 70, height: 70),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () async {
                    AppConstants.getFileMultiplePhoneAndVideo().then((result) {
                      if (result != null) {
                        setState(() {
                          selectedFiles =
                              result.paths.map((path) => File(path!)).toList();
                        });
                        print('selected file --> ${selectedFiles.toString()}');
                      } else {
                        // User canceled the picker
                      }
                    });

                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyPictureScreen(),));
                  },
                  child: const Center(
                    child: Text(
                      AppConstants.uploadPhotoOrVideo,
                      style: TextStyle(
                          color: AppConstants.clrSkyBlueTxt,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize17),
                    ),
                  ),
                ),
              ),
              selectedFiles.isEmpty
                  ? Container()
                  : ListView.builder(
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) {
                        return Text(
                          'File ${index + 1} : ' +
                              selectedFiles[index].toString().split('/').last,
                          style: const TextStyle(color: AppConstants.clrWhite),
                        );
                      }),
              Center(
                child: CustomButton(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: AppConstants.displayWidth(context) * 0.5,
                    onTap: () {
                      if (titleController.text.isEmpty) {
                        showToast('Please Enter Title');
                      } else if (timeController.text.isEmpty) {
                        showToast('Please Enter Time');
                      } else if (commentController.text.isEmpty) {
                        showToast('Please Enter Comment');
                      } else if (selectedFiles.isEmpty) {
                        showToast('Please Select Media');
                      } else {
                        postFillInPassModel.title =
                            titleController.text.toString();
                        postFillInPassModel.time =
                            timeController.text.toString();
                        postFillInPassModel.comment =
                            commentController.text.toString();
                        postFillInPassModel.media =
                            selectedFiles[0].path.toString();


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocationScreen()));
                      }
                    },
                    padding: const EdgeInsets.all(10),
                    radius: 12,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize17,
                    text: AppConstants.next,
                    textColor: AppConstants.clrWhite,
                    color: AppConstants.clrDialogBtnYesBg,
                    fontWeight: FontWeight.w700,
                    icon: false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
