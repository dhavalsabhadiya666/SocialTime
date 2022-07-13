import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinmetar_app/controllers/add_applicant_controller.dart';
import 'package:pinmetar_app/custom_widget/amap_widget.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/custom_widget/maps_sheet.dart';
import 'package:pinmetar_app/custom_widget/textfield_widget.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/user_model.dart';
import 'package:pinmetar_app/screen/me/my_video.dart';
import 'package:pinmetar_app/screen/me/temp_video.dart';
import 'package:pinmetar_app/screen/video/camera_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:video_thumbnail/video_thumbnail.dart';

class FillApplicationDetail extends StatefulWidget {
  bool? isEdit;

  FillApplicationDetail(this.isEdit, {Key? key}) : super(key: key);

  @override
  _FillApplicationDetailState createState() => _FillApplicationDetailState();
}

class _FillApplicationDetailState extends StateMVC<FillApplicationDetail> {
  late AddApplicantController _con;

  _FillApplicationDetailState() : super(AddApplicantController()) {
    _con = controller as AddApplicantController;
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController addSkillController = TextEditingController();
  bool isExpanded = true;
  String radioItem = 'Item 3';
  String employmentRadioItem = '3';
  XFile? selectedFile12;
  File? selectedVideoFile;
  String? videoThumbnailHttpToFile = '';
  Uint8List? videoThumbnailFileToUint8list;

  UserDataModel userDataModel = UserDataModel();
  double latitude = 37.759392;
  double longitude = -122.5107336;
  String currentAddress = '';
  int zoom = 18;

  DateTime selectedDate = DateTime.now();

  List<String>? skillList =['1','2','3','4','5'];
  List<String>? addSkillList =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    _con.getSkillApi();
    birthdayController = MaskedTextController(mask: '0000');
    if (widget.isEdit == true) {
      getApplicationData();
    }
    print('videoThumbnailHttpToFile    ${videoThumbnailHttpToFile}');
    print('videoThumbnailFileToUint8list    ${videoThumbnailFileToUint8list}');
  }

  Future getUserData() async {
    await Shared_Preferences.prefGetString(Shared_Preferences.keyUserData, "")
        .then((user) {
      if (user != null) {
        userDataModel = UserDataModel.fromJson(jsonDecode(user));
        print("User data --->" + userDataModel.toJson().toString());
        setState(() {});
      }
    });
  }

  getApplicationData() {
    _con.getApplicantDetailEditApi().then((value) async {
      if(_con.getApplicantEditData != null){
        userNameController.text = _con.getApplicantEditData.name==null?'':_con.getApplicantEditData.name.toString();
        titleController.text = _con.getApplicantEditData.title==null?'':_con.getApplicantEditData.title.toString();
        birthdayController.text = _con.getApplicantEditData.dob==null?'':_con.getApplicantEditData.dob.toString();
        employmentRadioItem = _con.getApplicantEditData.employmentType.toString();
        skillController.text = _con.getApplicantEditData.skill==null?'': _con.getApplicantEditData.skill.toString();
        phoneNumberController.text = _con.getApplicantEditData.mobile.toString();
        if (_con.getApplicantEditData.location != null) {
          locationController.text = _con.getApplicantEditData.location.toString();
        }
        if (_con.getApplicantEditData.profileVideo != null) {
          videoThumbnailHttpToFile = await VideoThumbnail.thumbnailFile(
            video: _con.getApplicantEditData.profileVideo.toString(),
            thumbnailPath: (await getTemporaryDirectory()).path,
            //imageFormat: ImageFormat.WEBP,
            maxHeight: 64,
            quality: 75,
          );

          print('videoThumbnailEdit  ${videoThumbnailHttpToFile.toString()}');
        }
      }
      setState(() {});
    });
  }

  List<File> selectedFiles = [];
  List<String> selectedFilesPath = [];

  // String? selectedFilesType;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor: AppConstants.clrBlack,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            //  height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery
                .of(context)
                .size
                .width,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(top: 25, right: 20,left: 15),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppConstants.clrBtnBlueGradient2,
                    AppConstants.clrBtnBlueGradient1,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50))),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppConstants.clrWhite,
                          size: 25,
                        )),
                    const SizedBox(width: 10),
                    const Text(
                      AppConstants.fillInApplicantDetails,
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.mediumFontSize18,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialogForUserImage();
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: AppConstants.clrWhite),
                                      image: selectedFile12 != null
                                          ? DecorationImage(
                                          image: FileImage(File(
                                              selectedFile12!.path
                                                  .toString())),
                                          fit: BoxFit.cover)
                                          : _con.getApplicantEditData
                                          .profileImage !=
                                          null
                                          ? DecorationImage(
                                          image: NetworkImage(_con
                                              .getApplicantEditData
                                              .profileImage
                                              .toString()),
                                          fit: BoxFit.cover)
                                          : const DecorationImage(
                                          image: AssetImage(
                                              AppConstants.userProfile),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: Container(
                                      height: 33,
                                      width: 33,
                                      child: const Center(
                                          child: Icon(
                                            Icons.photo_camera,
                                            color: AppConstants.clrWhite,
                                            size: 18,
                                          )),
                                      decoration: BoxDecoration(
                                          color: AppConstants.clrBlack26,
                                          border: Border.all(
                                              width: 2,
                                              color: AppConstants
                                                  .clrBtnBlueGradient2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                    ))
                              ],
                            ),
                          ),
                          Text(
                            userDataModel != null
                                ? userDataModel.name.toString()
                                : '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppConstants.clrWhite,
                                fontSize: AppConstants.mediumFontSize16,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              videoRequestDialog123(context);
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: AppConstants.clrWhite),
                                      image: videoThumbnailFileToUint8list != null
                                          ? DecorationImage(
                                          image: MemoryImage(
                                              videoThumbnailFileToUint8list!),
                                          fit: BoxFit.cover)
                                          : videoThumbnailHttpToFile != null &&
                                          videoThumbnailHttpToFile !=
                                              '' &&
                                          videoThumbnailHttpToFile!
                                              .isNotEmpty
                                          ? DecorationImage(
                                          image: FileImage(File(
                                              videoThumbnailHttpToFile
                                                  .toString())),
                                          fit: BoxFit.cover)
                                          : const DecorationImage(
                                          image: AssetImage(
                                              AppConstants.userProfile),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: Container(
                                      height: 33,
                                      width: 33,
                                      child: const Center(
                                          child: Icon(
                                            Icons.videocam_rounded,
                                            color: AppConstants.clrWhite,
                                            size: 18,
                                          )),
                                      decoration: BoxDecoration(
                                          color: AppConstants.clrBlack26,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 2,
                                              color: AppConstants
                                                  .clrBtnBlueGradient2)),
                                    ))
                              ],
                            ),
                          ),
                          const Text(
                            AppConstants.videoSelfIntroduction,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontSize: AppConstants.mediumFontSize16,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 15),
            children: [
              Form(
                key: _con.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        AppConstants.actualName,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    textFieldWidget(
                      hint: AppConstants.enterActualName,
                      controller: userNameController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          AppConstants.icUser,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter actual name';
                        } else {
                          return null;
                        }
                      },
                      // onChanged: (value) =>
                      //     _con.addApplicantDetailsModel.name = value.toString(),
                      onSaved: (value) =>
                      _con.addApplicantDetailsModel.name = value.toString(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.title,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    textFieldWidget(
                        hint: AppConstants.enterTitle,
                        controller: titleController,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(AppConstants.icTitle,
                              height: 25, width: 25),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter title';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                        _con
                            .addApplicantDetailsModel.title =
                            value.toString()),
                    // onChanged: (value) => _con
                    //     .addApplicantDetailsModel.title = value.toString()),

                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.birthday,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Select Birthday Year"),
                              content: Container( // Need to use container to add size constraint.
                                width: 300,
                                height: 300,
                                child: YearPicker(
                                  firstDate: DateTime(DateTime.now().year - 100, 1),
                                  lastDate: DateTime(DateTime.now().year + 100, 1),
                                  initialDate: DateTime.now(),
                                  selectedDate: selectedDate,
                                  onChanged: (DateTime dateTime) {
                                    birthdayController.text = dateTime.toString();
                                    Navigator.pop(context);

                                  },
                                ),
                              ),
                            );
                          },
                        );
                        // final DateTime? picked = await showDatePicker(
                        //     context: context,
                        //     initialDate: selectedDate,
                        //     initialDatePickerMode: DatePickerMode.year,
                        //     firstDate: DateTime(2015),
                        //     lastDate: DateTime(2101));
                        // if (picked != null) {
                        //   setState(() {
                        //     selectedDate = picked;
                        //     print('selectedDate  ${selectedDate}');
                        //   //  _dateController.text = DateFormat.yMd().format(selectedDate);
                        //   });
                        // }
                      },
                      child: TextFormField(
                        style: const TextStyle(color: AppConstants.clrWhite),
                        controller: birthdayController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter birthday';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                        _con
                            .addApplicantDetailsModel.birthday =
                            value.toString(),
                        // onChanged: (value) => _con.addApplicantDetailsModel
                        //     .birthday = value.toString()
                      decoration: InputDecoration(
                        enabled: false,
                          contentPadding: const EdgeInsets.only(
                              top: 10, left: 10),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(AppConstants.icYear,
                                height: 25, width: 25),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: AppConstants
                                .clrBlack26),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: AppConstants
                                .clrBlack26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: AppConstants
                                .clrBlack26),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: AppConstants
                                .clrBlack26),
                          ),
                          focusColor: AppConstants.clrTransparent,
                          filled: true,
                          hintStyle: const TextStyle(
                              color: AppConstants.clrLightGreyTxt),
                          hintText: AppConstants.enterYear,
                        ),),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.phoneNumber,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      // height: 50,
                      child: TextFormField(
                        style: const TextStyle(color: AppConstants
                            .clrWhite),
                        controller: phoneNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone number';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                        _con
                            .addApplicantDetailsModel.mobile = value
                            .toString(),
                        // onChanged: (value) => _con
                        //     .addApplicantDetailsModel.mobile = value.toString(),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding:
                          const EdgeInsets.only(top: 10, left: 10),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              AppConstants.icPhone,
                              height: 25,
                              width: 25,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: AppConstants.clrBlack26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: AppConstants.clrBlack26),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: AppConstants.clrBlack26),
                          ),
                          focusColor: AppConstants.clrTransparent,
                          filled: true,
                          hintStyle: const TextStyle(
                              color: AppConstants.clrLightGreyTxt),
                          hintText: AppConstants.enterPhoneNumber,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.location,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants
                              .clrBlack26),
                          color: AppConstants.clrTransparent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppConstants.icLocations,
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                AppConstants.chooseLocations,
                                style: TextStyle(
                                    color: AppConstants.clrLightGreyTxt,
                                    fontSize: AppConstants.mediumFontSize15,
                                    fontFamily: AppConstants
                                        .fontPoppinsRegular,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                  AppConstants.clrRadioOffBtn,
                                  disabledColor: AppConstants
                                      .clrRadioOffBtn),
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                groupValue: radioItem,
                                title: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      radioItem = 'Item 1';
                                    });
                                    AppConstants.getGeoLocationPosition()
                                        .then((value) async {
                                      if (value != null) {
                                        print("latitude-  ${value
                                            .latitude}  - longitude -${value
                                            .longitude}");
                                        AppConstants.getAddressFromLatLong(
                                            value.latitude, value.longitude)
                                            .then((addressValue) {
                                          if (addressValue != null) {
                                            currentAddress =
                                            '${addressValue.subLocality
                                                .toString()} ${addressValue
                                                .locality
                                                .toString()} ${addressValue
                                                .administrativeArea
                                                .toString()}, ${addressValue
                                                .postalCode.toString()}';

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //       ShowMapPageBody(),
                                            //     ));

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AMapWidget(value.latitude,
                                                          value.longitude),
                                                ));


                                            // MapsSheet.show(
                                            //   context: context,
                                            //   onMapTap: (map) {
                                            //     map.showMarker(
                                            //       coords: Coords(
                                            //           value.latitude,
                                            //           value.longitude),
                                            //       title: currentAddress,
                                            //       zoom: zoom,
                                            //     );
                                            //   },
                                            // );
                                          }
                                        });
                                      }
                                    });
                                  },
                                  child: Text(AppConstants.currentLocation,
                                      style: TextStyle(
                                          color: radioItem == "Item 1"
                                              ? AppConstants.clrWhite
                                              : AppConstants.clrWhite,
                                          fontSize:
                                          AppConstants.mediumFontSize16,
                                          fontFamily:
                                          AppConstants.fontPoppinsRegular)),
                                ),
                                value: 'Item 1',
                                activeColor: AppConstants.clrWhite,
                                onChanged: (val) {
                                  setState(() {
                                    print('$val');
                                    radioItem = val.toString();
                                    AppConstants.getGeoLocationPosition()
                                        .then((value) async {
                                      if (value != null) {
                                        print("latitude fill app-  ${value
                                            .latitude}  - longitude -${value
                                            .longitude}");
                                        AppConstants.getAddressFromLatLong(
                                            value.latitude, value.longitude)
                                            .then((addressValue) {
                                          if (addressValue != null) {
                                            currentAddress =
                                            '${addressValue.subLocality
                                                .toString()} ${addressValue
                                                .locality
                                                .toString()} ${addressValue
                                                .administrativeArea
                                                .toString()}, ${addressValue
                                                .postalCode.toString()}';
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           AMapWidget(value.latitude,
                                            //               value.longitude),
                                            //     ));


                                            // MapsSheet.show(
                                            //   context: context,
                                            //   onMapTap: (map) {
                                            //     map.showMarker(
                                            //       coords: Coords(
                                            //           value.latitude,
                                            //           value.longitude),
                                            //       title: currentAddress,
                                            //       zoom: zoom,
                                            //     );
                                            //   },
                                            // );
                                          }
                                        });
                                      }
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                  AppConstants.clrRadioOffBtn,
                                  disabledColor: AppConstants
                                      .clrRadioOffBtn),
                              child: RadioListTile(
                                groupValue: radioItem,
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppConstants.clrWhite,
                                title: Text(AppConstants.onLine,
                                    style: TextStyle(
                                        color: radioItem == "Item 2"
                                            ? AppConstants.clrWhite
                                            : AppConstants.clrWhite,
                                        fontSize: AppConstants
                                            .mediumFontSize16,
                                        fontFamily:
                                        AppConstants.fontPoppinsRegular)),
                                value: 'Item 2',
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                  AppConstants.clrRadioOffBtn,
                                  disabledColor: AppConstants
                                      .clrRadioOffBtn),
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                groupValue: radioItem,
                                title: Text(AppConstants.enterByMyself,
                                    style: TextStyle(
                                        color: radioItem == "Item 3"
                                            ? AppConstants.clrWhite
                                            : AppConstants.clrWhite,
                                        fontSize: AppConstants
                                            .mediumFontSize16,
                                        fontFamily:
                                        AppConstants.fontPoppinsRegular)),
                                value: 'Item 3',
                                activeColor: AppConstants.clrWhite,
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          radioItem == 'Item 3'
                              ? Padding(
                            padding: const EdgeInsets.only(
                                left: 70, right: 30),
                            child: textFieldWidget(
                              hint: 'xx state xxx Rd. xxx St....',
                              controller: locationController,
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.employmentType,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants
                              .clrBlack26),
                          color: AppConstants.clrTransparent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppConstants.icEmployment,
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                AppConstants.chooseEmploymentType,
                                style: TextStyle(
                                    color: AppConstants.clrLightGreyTxt,
                                    fontSize: AppConstants.mediumFontSize15,
                                    fontFamily: AppConstants
                                        .fontPoppinsRegular,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                  AppConstants.clrRadioOffBtn,
                                  disabledColor: AppConstants
                                      .clrRadioOffBtn),
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                groupValue: employmentRadioItem,
                                title: Text(AppConstants.currentlyAvailable,
                                    style: TextStyle(
                                        color: employmentRadioItem == "1"
                                            ? AppConstants.clrWhite
                                            : AppConstants.clrWhite,
                                        fontSize: AppConstants
                                            .mediumFontSize16,
                                        fontFamily:
                                        AppConstants.fontPoppinsRegular)),
                                value: '1',
                                activeColor: AppConstants.clrWhite,
                                onChanged: (val) {
                                  setState(() {
                                    employmentRadioItem = val.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                  AppConstants.clrRadioOffBtn,
                                  disabledColor: AppConstants
                                      .clrRadioOffBtn),
                              child: RadioListTile(
                                groupValue: employmentRadioItem,
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppConstants.clrWhite,
                                title: Text(AppConstants.unavailable,
                                    style: TextStyle(
                                        color: employmentRadioItem == "2"
                                            ? AppConstants.clrWhite
                                            : AppConstants.clrWhite,
                                        fontSize: AppConstants
                                            .mediumFontSize16,
                                        fontFamily:
                                        AppConstants.fontPoppinsRegular)),
                                value: '2',
                                onChanged: (val) {
                                  setState(() {
                                    employmentRadioItem = val.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                  AppConstants.clrRadioOffBtn,
                                  disabledColor: AppConstants
                                      .clrRadioOffBtn),
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                groupValue: employmentRadioItem,
                                title: Text(AppConstants.partiallyAvailable,
                                    style: TextStyle(
                                        color: employmentRadioItem == "3"
                                            ? AppConstants.clrWhite
                                            : AppConstants.clrWhite,
                                        fontSize: AppConstants
                                            .mediumFontSize16,
                                        fontFamily:
                                        AppConstants.fontPoppinsRegular)),
                                value: '3',
                                activeColor: AppConstants.clrWhite,
                                onChanged: (val) {
                                  setState(() {
                                    employmentRadioItem = val.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.skill,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _con.getSkillApi();
                        skillDialog(context);
                      },
                      child: TextFormField(
                        style: const TextStyle(color: AppConstants.clrWhite),
                        controller: skillController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter skill';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                        _con.addApplicantDetailsModel.skill = value,
                        decoration: InputDecoration(
                          enabled: false,
                            contentPadding: const EdgeInsets.only(top: 10,left: 10),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(AppConstants.icSkill,
                                  height: 25, width: 25),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: AppConstants.clrBlack26),
                            ),
                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: AppConstants.clrBlack26),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: AppConstants.clrBlack26),
                            ) ,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: AppConstants.clrBlack26),
                            ),
                            focusColor: AppConstants.clrTransparent,
                            filled: true,
                            hintStyle: const TextStyle(color: AppConstants.clrLightGreyTxt),
                            hintText: AppConstants.enterSkill),


                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Text(
                        AppConstants.cVCertificate,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize15,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppConstants.getDocPickOneFile().then((result) {
                          if (result != null) {
                            setState(() {
                              selectedFiles = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              if (selectedFilesPath != null) {
                                selectedFilesPath.clear();
                              }
                              if (selectedFiles != null) {
                                selectedFiles.forEach((element) {
                                  selectedFilesPath.add(
                                      element.path.toString());
                                });
                              }
                              setState(() {});
                              // selectedFilesType = selectedFiles![0]
                              //     .path
                              //     .toString()
                              //     .split('/')
                              //     .last
                              //     .toString()
                              //     .replaceAll(']', '')
                              //     .split('.')
                              //     .last
                              //     .toString();
                            });
                            print(
                                'selectedFiles file --> ${selectedFiles
                                    .toString()}');
                            print(
                                'selectedFilesPath file --> ${selectedFilesPath
                                    .toString()}');
                          } else {
                            // User canceled the picker
                          }
                        });
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: AppConstants.clrLightGreyTxt,
                        strokeWidth: 2,
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(AppConstants.icPlus,
                                  height: 35, width: 35),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.addToCVCertificate,
                                style: TextStyle(
                                    color: AppConstants.clrLightGreyTxt,
                                    fontSize: AppConstants.mediumFontSize12,
                                    fontFamily: AppConstants
                                        .fontPoppinsRegular,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        // child: _con.getApplicantEditData.cvCertificate ==null?
                        // Center(
                        //   child: selectedFilesType !=null? selectedFilesType!.toLowerCase()
                        //       .toString() == 'png' ||
                        //       selectedFilesType!.toLowerCase().toString() ==
                        //           'jepg' ||
                        //       selectedFilesType!.toLowerCase().toString() ==
                        //           'jpg' ?
                        //   Container(
                        //       height: 90,
                        //       width: 90,
                        //       decoration: BoxDecoration(
                        //           image: DecorationImage(image: FileImage(
                        //               File(selectedFiles!.path.toString()
                        //                   .replaceAll('[', '')
                        //                   .replaceAll(']', ''))),fit: BoxFit.cover)),
                        //       /*child: IconButton(
                        //         alignment: Alignment.topRight,
                        //         icon: const Icon(Icons.clear,color: AppConstants.clrWhite),
                        //         onPressed: (){
                        //           setState(() {
                        //             selectedFiles!.delete();
                        //           });
                        //
                        //         },
                        //       )*/ )
                        //       : selectedFilesType!.toLowerCase()
                        //       .toString() == 'pdf' ||
                        //       selectedFilesType!.toLowerCase().toString() ==
                        //           'docx'? const Icon(Icons.file_copy_outlined,color: AppConstants.clrWhite,size: 50)
                        //               :
                        //  Container(): Column(
                        //     children: [
                        //       Image.asset(AppConstants.icPlus,
                        //           height: 35, width: 35),
                        //       const SizedBox(height: 8),
                        //       const Text(
                        //         AppConstants.addToCVCertificate,
                        //         style: TextStyle(
                        //             color: AppConstants.clrLightGreyTxt,
                        //             fontSize: AppConstants.mediumFontSize12,
                        //             fontFamily: AppConstants
                        //                 .fontPoppinsRegular,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //       selectedFiles == null
                        //           ? Container()
                        //           : Text(
                        //         'File Name: ${selectedFiles!
                        //             .path
                        //             .toString()
                        //             .split('/')
                        //             .last
                        //             .toString()
                        //             .replaceAll(']', '')}',
                        //         style: const TextStyle(
                        //             color: AppConstants.clrLightGreyTxt,
                        //             fontSize:
                        //             AppConstants.mediumFontSize12,
                        //             fontFamily:
                        //             AppConstants.fontPoppinsRegular,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //     ],
                        //   ),
                        // ):
                        // _con.getApplicantEditData.cvCertificate!.split('.').last.toString() == 'png' || _con.getApplicantEditData.cvCertificate!.split('.').last.toString() == 'jepg'||_con.getApplicantEditData.cvCertificate!.split('.').last.toString() == 'jpg'  ?
                        // Center(
                        //   child: Container(
                        //     height: 90,
                        //     width: 90,
                        //     decoration: BoxDecoration(
                        //         image: DecorationImage(image: NetworkImage(
                        //             _con.getApplicantEditData.cvCertificate.toString()),fit: BoxFit.cover)),
                        //   ),
                        // ):const Center(child: Icon(Icons.file_copy_outlined,color: AppConstants.clrWhite,size: 50)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      AppConstants.allowToAttach,
                      style: TextStyle(
                          color: AppConstants.clrLightGreyTxt,
                          fontSize: AppConstants.mediumFontSize12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: AppConstants.displayWidth(context) * 0.2,
                child: selectedFiles.toString() != '[]' ?
                ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: selectedFiles.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int i) {
                      print('selectedFiles: ${selectedFiles.length}');
                      return Stack(
                        children: [
                          Container(
                            width: AppConstants.displayWidth(context) * 0.2,
                            height: AppConstants.displayWidth(context) *
                                0.2,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: selectedFiles[i]
                                    .path
                                    .toString()
                                    .split('.')
                                    .last ==
                                    'png' ||
                                    selectedFiles[i]
                                        .path
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'PNG' ||
                                    selectedFiles[i]
                                        .path
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'jpg' ||
                                    selectedFiles[i]
                                        .path
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'JPG' ||
                                    selectedFiles[i]
                                        .path
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'jpeg' ||
                                    selectedFiles[i]
                                        .path
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'JPEG'
                                    ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                        File(selectedFiles[i].path
                                            .toString())))
                                    : const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        AppConstants.file_icon))),
                          ),
                          Positioned(
                            top: -15,
                            right: -5,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedFiles.removeAt(i);
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined,
                                color: AppConstants.clrBlack, size: 18,),
                            ),
                          )
                        ],
                      );
                    })
                    : _con.getApplicantEditData.cvCertificate == null
                    ? Container()
                    :
                ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _con.getApplicantEditData.cvCertificate!
                        .length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int i) {
                      print(
                          '_con.getApplicantEditData.cvCertificate : ${_con
                              .getApplicantEditData.cvCertificate!
                              .length}');
                      return Stack(
                        children: [
                          Container(
                            width: AppConstants.displayWidth(context) * 0.2,
                            height: AppConstants.displayWidth(context) *
                                0.2,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: _con.getApplicantEditData
                                    .cvCertificate![i]
                                    .toString()
                                    .split('.')
                                    .last ==
                                    'png' ||
                                    _con.getApplicantEditData
                                        .cvCertificate![i]
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'PNG' ||
                                    _con.getApplicantEditData
                                        .cvCertificate![i]
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'jpg' ||
                                    _con.getApplicantEditData
                                        .cvCertificate![i]
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'JPG' ||
                                    _con.getApplicantEditData
                                        .cvCertificate![i]
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'jpeg' ||
                                    _con.getApplicantEditData
                                        .cvCertificate![i]
                                        .toString()
                                        .split('.')
                                        .last ==
                                        'JPEG'
                                    ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        _con.getApplicantEditData
                                            .cvCertificate![i]
                                            .toString()))
                                    : const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        AppConstants.file_icon))),
                          ),
                          // Positioned(
                          //   top: -15,
                          //   right: -5,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         selectedFiles.removeAt(i);
                          //       });
                          //     },
                          //     icon: const Icon(Icons.cancel_outlined, color: AppConstants.clrBlack, size: 18,),
                          //   ),
                          // )
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        height: 40,
                        //  width: AppConstants.displayWidth(context) * 0.45,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        textColor: AppConstants.clrWhite,
                        radius: 10,
                        color: AppConstants.clrBlack26,
                        text: AppConstants.cancel,
                        fontSize: AppConstants.mediumFontSize15,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        height: 40,
                        // width: AppConstants.displayWidth(context) * 0.45,
                        onTap: () {
                          _con.addApplicantDetailsModel.employmentType =
                              int.parse(employmentRadioItem.toString());
                          if (radioItem == 'Item 1') {
                            _con.addApplicantDetailsModel.location =
                                currentAddress.toString();
                          } else {
                            _con.addApplicantDetailsModel.location =
                                locationController.text.toString();
                          }
                          if (selectedFiles != null) {
                            print('cvCertificate list   ${selectedFilesPath
                                .toString()}');
                            _con.cvCertificate =
                                selectedFilesPath /*selectedFiles[0]
                            .path
                            .toString()
                            .replaceAll(']', '')
                            .replaceAll('[', '')*/
                            ;
                          }
                          if (selectedFile12 != null) {
                            _con.profilePhoto =
                                selectedFile12!.path.toString();
                          }
                          if (selectedVideoFile != null) {
                            _con.profileVideo =
                                selectedVideoFile!.path.toString();
                          }

                          _con.useraddApplicantDetailApi(context);
                          // if(selectedFile ==null){
                          //   showToast('Please Select Profile Image');
                          // }else{
                          //
                          // }
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicantInfoScreen(),));
                        },
                        textColor: AppConstants.clrWhite,
                        radius: 10,
                        color: AppConstants.clrDialogBtnYesBg,
                        text: AppConstants.save,
                        fontSize: AppConstants.mediumFontSize15,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  showDialogForUserImage() {
    const textStyle =
    TextStyle(color: AppConstants.clrWhite, fontWeight: FontWeight.w400);
    showCupertinoModalPopup(
        context: context,
        builder: (a) =>
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Material(
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppConstants.clrPrimary,
                            gradient: AppConstants().linearGradient),
                        // padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 50,
                              color: AppConstants.clrPrimary,
                              child: const Center(
                                child: Text(
                                  "Select Image",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppConstants.clrWhite,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(a).pop();
                                    selectImage(ImageSource.gallery);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.image_rounded,
                                        color: AppConstants.clrWhite,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Gallery",
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 12,
                                  width: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(a).pop();
                                    selectImage(ImageSource.camera);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.camera_alt_rounded,
                                        color: AppConstants.clrWhite,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Camera",
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )))));
  }

  selectImage(ImageSource source) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    final ImagePicker _picker = ImagePicker();
    selectedFile12 = await _picker.pickImage(source: source);
    setState(() {
      if (selectedFile12 != null) {
        print('selectedFile photo' + selectedFile12!.path.toString());
        setState(() {});
        setState(() {});
      }
    });
  }

  videoRequestDialog123(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      AppConstants.whichVideoWouldYouLikeToSubmitToRequester,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize16,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrWhite,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 15),
                  CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 45,
                    padding: const EdgeInsets.all(8),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TempVideoScreen()/*MyVideoScreen()*/)).then((value) async {
                                if(value != null){
                                  print('temp video file --> ${value.toString()}');
                                  selectedVideoFile = value;
                                  videoThumbnailFileToUint8list =
                                  await VideoThumbnail.thumbnailData(
                                    video: value.path.toString(),
                                    //  imageFormat: ImageFormat.JPEG,
                                    maxWidth: 128,
                                    quality: 25,
                                  );
                                  setState(() {});
                                }

                      });
                    },
                    color: AppConstants.clrBtnBlueGradient2,
                    icon: true,
                    text: AppConstants.useApplicantProfileVideo,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Image.asset(
                      AppConstants.profile,
                      height: 15,
                      width: 15,
                    ),
                    radius: 12,
                    textColor: AppConstants.clrWhite,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    width: AppConstants.displayWidth(context),
                    height: 45,
                    padding: const EdgeInsets.all(8),
                    onTap: () async {
                      try {
                        WidgetsFlutterBinding.ensureInitialized();
                        cameras = await availableCameras();
                      } on CameraException catch (e) {
                        print('Error in fetching the cameras: $e');
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraScreen('ApplicantProfile')))
                          .then((value) async {
                        if (value != null) {
                          selectedVideoFile = value;
                          videoThumbnailFileToUint8list =
                          await VideoThumbnail.thumbnailData(
                            video: selectedVideoFile!.path,
                            //  imageFormat: ImageFormat.JPEG,
                            maxWidth: 128,
                            quality: 25,
                          );
                          setState(() {});
                        }
                        print('video file -- ${value.toString()}');
                      });
                    },
                    color: AppConstants.clrBtnTeal,
                    icon: true,
                    text: AppConstants.recordLivVideo,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontSize: AppConstants.mediumFontSize15,
                    image: Image.asset(
                      AppConstants.video,
                      height: 15,
                      width: 15,
                    ),
                    radius: 12,
                    textColor: AppConstants.clrWhite,
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                      height: 50,
                      width: AppConstants.displayWidth(context),
                      onTap: () => Navigator.pop(context),
                      padding: const EdgeInsets.all(10),
                      radius: 12,
                      fontFamily: AppConstants.fontPoppinsRegular,
                      fontSize: AppConstants.mediumFontSize15,
                      text: AppConstants.cancel,
                      textColor: AppConstants.clrWhite,
                      color: AppConstants.clrDialogBtnYesBg,
                      icon: false),
                ],
              ),
            ),
          );
        });
  }

  skillDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: StatefulBuilder(
              builder: (BuildContext context, setState1) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(15,15,15,10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppConstants.icSkill,
                              height: 20, width: 20),
                          const SizedBox(width: 8),
                          const Text('Select Skill',
                              style:
                              TextStyle(color: AppConstants.clrWhite)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: _con.getSkillDataModel!.map((e) {
                          return GestureDetector(
                            onTap: (){
                              if(addSkillList!.contains(e.skill.toString())){
                                addSkillList!.remove(e.skill.toString());
                              }else{
                                addSkillList!.add(e.skill.toString());
                              }
                              setState1(() { });
                              print('addSkillList  ${addSkillList.toString()}');

                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                //    width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: addSkillList!.contains(e.skill.toString())?AppConstants.clrPrimary.withOpacity(0.5):AppConstants.clrBlack,
                                    borderRadius: BorderRadius.circular(8)),
                                margin:
                                const EdgeInsets.only(right: 10, bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Text(e.skill.toString(),
                                    style: const TextStyle(
                                        color: AppConstants.clrWhite)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState1((){
                                  skillController.text = addSkillList.toString().replaceAll('[', '').replaceAll(']', '');
                                });

                               Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppConstants.clrPrimary,
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.only(right: 8, bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: const Text('Save',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,fontSize: 13,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                addSkillDialog(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppConstants.clrPrimary,
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.only(right: 8, bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: const Text('Add Other Skill',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,fontSize: 13,fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  addSkillDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: StatefulBuilder(
              builder: (BuildContext context, stateSetter1) {
                return Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Text(
                          'Add Other Skill',
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize15,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.clrWhite),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 15),
                      textFieldWidget(
                        hint: 'Enter Skill',
                        controller: addSkillController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            AppConstants.icSkill,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: AppConstants.displayWidth(context) * 0.45,
                        onTap: () {
                          _con.addOtherSkillApi(addSkillController.text.toString()).then((value) {
                            _con.getSkillApi();
                            addSkillList!.add(addSkillController.text.toString());
                            skillController.text = addSkillList.toString().replaceAll('[', '').replaceAll(']', '');
                            stateSetter1(() { });
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        textColor: AppConstants.clrWhite,
                        radius: 10,
                        color: AppConstants.clrDialogBtnYesBg,
                        text: AppConstants.save,
                        fontSize: AppConstants.mediumFontSize17,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontWeight: FontWeight.w600,
                      ),

                    ],
                  ),
                );
              },
            ),
          );
        });
  }

}
