import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/controllers/pin_controller.dart';
import 'package:pinmetar_app/custom_widget/amap_widget.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/screen/pin/post_help_preview_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends StateMVC<LocationScreen> {
  PinController? _con;

  _LocationScreenState() : super(PinController()) {
    _con = controller as PinController;
  }

  TextEditingController locationController = TextEditingController();
  String radioItem = '3';
  bool isExpanded = true;
  String currentAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                          size: 25, color: AppConstants.clrWhite),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      AppConstants.location1,
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.mediumFontSize20,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear_sharp,
                      color: AppConstants.clrWhite,
                      size: 25,
                    ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                AppConstants.step2Of3Location,
                style: TextStyle(
                    color: AppConstants.clrWhite,
                    fontSize: AppConstants.mediumFontSize15,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontWeight: FontWeight.w500),
              ),
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
                        border: Border.all(color: AppConstants.clrButtonGreen),
                        color: AppConstants.clrButtonGreen),
                    child: const Center(
                      child: Text('2',
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
                          color: AppConstants.clrLightGreyTxt),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppConstants.clrLightGreyTxt),
                        color: AppConstants.clrBlack),
                    child: const Center(
                      child: Text('3',
                          style: TextStyle(
                              color: AppConstants.clrLightGreyTxt,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize20,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: AppConstants.clrLightGreyTxt,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppConstants.locationImage,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                AppConstants.location,
                                style: TextStyle(
                                    color: AppConstants.clrWhite,
                                    fontSize: AppConstants.mediumFontSize15,
                                    fontFamily:
                                        AppConstants.fontPoppinsRegular),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: AppConstants.clrWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                  isExpanded == true
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          decoration: const BoxDecoration(
                              color: AppConstants.clrBlack26,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:
                                        AppConstants.clrRadioOffBtn,
                                    disabledColor: AppConstants.clrRadioOffBtn),
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  groupValue: radioItem,
                                  title: Text(AppConstants.currentLocation,
                                      style: TextStyle(
                                          color: radioItem == "1"
                                              ? AppConstants.clrSkyBlueTxt
                                              : AppConstants.clrWhite,
                                          fontSize:
                                              AppConstants.mediumFontSize16,
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular)),
                                  value: '1',
                                  activeColor: AppConstants.clrSkyBlueTxt,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val.toString();
                                    });
                                    AppConstants.getGeoLocationPosition()
                                        .then((value) async {
                                      if (value != null) {
                                        print("latitude-  ${value.latitude}  - longitude -${value.longitude}");
                                        AppConstants.getAddressFromLatLong(
                                                value.latitude, value.longitude)
                                            .then((addressValue) {
                                          if (addressValue != null) {
                                            currentAddress =
                                                '${addressValue.subLocality.toString()} ${addressValue.locality.toString()} ${addressValue.administrativeArea.toString()}, ${addressValue.postalCode.toString()}';
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AMapWidget(value.latitude,
                                                          value.longitude),
                                                ));
                                          }
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:
                                        AppConstants.clrRadioOffBtn,
                                    disabledColor: AppConstants.clrRadioOffBtn),
                                child: RadioListTile(
                                  groupValue: radioItem,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: AppConstants.clrSkyBlueTxt,
                                  title: Text(AppConstants.onLine,
                                      style: TextStyle(
                                          color: radioItem == "2"
                                              ? AppConstants.clrSkyBlueTxt
                                              : AppConstants.clrWhite,
                                          fontSize:
                                              AppConstants.mediumFontSize16,
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular)),
                                  value: '2',
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val.toString();
                                    });
                                  },
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:
                                        AppConstants.clrRadioOffBtn,
                                    disabledColor: AppConstants.clrRadioOffBtn),
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  groupValue: radioItem,
                                  title: Text(
                                      AppConstants.enterByMyself,
                                      style: TextStyle(
                                          color: radioItem == "3"
                                              ? AppConstants.clrSkyBlueTxt
                                              : AppConstants.clrWhite,
                                          fontSize:
                                              AppConstants.mediumFontSize16,
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular)),
                                  value: '3',
                                  activeColor: AppConstants.clrSkyBlueTxt,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = val.toString();
                                    });
                                  },
                                ),
                              ),
                              radioItem == '3'
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 55, right: 30),
                                      child: TextFormField(
                                        controller: locationController,
                                        style: const TextStyle(
                                            fontFamily:
                                                AppConstants.fontPoppinsRegular,
                                            color: AppConstants.clrWhite),
                                        decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: AppConstants.clrLightGreyTxt)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: AppConstants
                                                        .clrLightGreyTxt)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: AppConstants
                                                        .clrLightGreyTxt)),
                                            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppConstants.clrLightGreyTxt)),
                                            labelText: AppConstants.enterByMyself,
                                            labelStyle: const TextStyle(fontSize: AppConstants.mediumFontSize16, fontFamily: AppConstants.fontPoppinsRegular, color: AppConstants.clrWhite)),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: CustomButton(
                          height: 50,
                          width: AppConstants.displayWidth(context) * 0.5,
                          onTap: () {
                            if (radioItem == '1') {
                              postFillInPassModel.location =
                                  currentAddress.toString();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostHelpPreviewScreen()));
                            } else {
                              if (locationController.text.isEmpty) {
                                showToast('Please Enter Location');
                              } else {
                                postFillInPassModel.location =
                                    locationController.text.toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PostHelpPreviewScreen()));
                              }
                            }
                            //postFillInPassModel.location =locationController.text.toString();
                            print('postFillInModel loc   ${postFillInPassModel.toJson()}');

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
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
