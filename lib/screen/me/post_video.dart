import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart' as ca;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinmetar_app/controllers/post_video_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/screen/video/camera_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PostVideoScreen extends StatefulWidget {
  File? videoFile;

  PostVideoScreen(this.videoFile, {Key? key}) : super(key: key);

  @override
  _PostVideoScreenState createState() => _PostVideoScreenState();
}

class _PostVideoScreenState extends StateMVC<PostVideoScreen> {
  PostController? _con;

  _PostVideoScreenState() : super(PostController()) {
    _con = controller as PostController;
  }

  TextEditingController videoDec = TextEditingController();
  bool isSwitched = false;
  //String videoRadioItem = 'Item 1';
  String privacyRadioItem = "1";


  Uint8List? videoThumbnail;
  List<String> tagName = [
    'Food',
    'Recipe',
    'Summer Class',
    'Veg Salad',
    'Cooking'
  ];

  List<String> addTagName =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThumbnail();
  }

  getThumbnail() async {
    if (widget.videoFile != null) {
      print('widget.videoFile ---> ${widget.videoFile.toString()}');
      videoThumbnail = await VideoThumbnail.thumbnailData(
        video: widget.videoFile!.path,
        imageFormat: ImageFormat.PNG,
        maxWidth: 128,
        // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 50,
      );
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/post.png').create();
      file.writeAsBytesSync(videoThumbnail!);
      _con!.postVideoModel.thumbnail = file.path.toString();
      setState(() { });
      print('videoThumbnail post video  ${file.path.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        elevation: 0,
        title: const Text(
          AppConstants.postVideo,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: AppConstants.clrWhite),
                  image:  videoThumbnail != null
                      ?DecorationImage(image: MemoryImage(videoThumbnail!),fit: BoxFit.cover)
                      :const DecorationImage(image: AssetImage(AppConstants.userProfile),fit: BoxFit.cover)
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        postVideoRequestDialog(context);
                      },
                      child: Container(
                        height: 33,
                        width: 33,
                        child: Center(
                            child: Image.asset(
                          AppConstants.icEdit,
                          height: 20,
                          width: 20,
                        )),
                        decoration: const BoxDecoration(
                            color: AppConstants.clrBlack26,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Divider(color: AppConstants.clrDivider1, height: 3),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppConstants.clrBlack26,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(AppConstants.icFile, height: 22, width: 22),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Video Description',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontSize: AppConstants.mediumFontSize16,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    style: const TextStyle(
                        color: AppConstants.clrWhite, fontSize: 14),
                    controller: videoDec,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5),
                      hintText: "Type Description...",
                      hintStyle: TextStyle(
                        color: AppConstants.clrLightGreyTxt,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppConstants.clrLightGreyTxt,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            tagDialog(context);
                          },
                          child: tag(AppConstants.hashtags)),
                      tag(AppConstants.friends)
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                //selectedDialog(context);
                whoCanViewDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    AppConstants.whoCanViewThisVideo,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: AppConstants.mediumFontSize14,
                        color: AppConstants.clrWhite,
                        fontFamily: AppConstants.fontPoppinsRegular),
                  ),
                  Text(
                    'All >',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: AppConstants.mediumFontSize14,
                        color: AppConstants.clrLightGreyTxt,
                        fontFamily: AppConstants.fontPoppinsRegular),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppConstants.allowThisVideoToBeDownloaded,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: AppConstants.mediumFontSize14,
                      color: AppConstants.clrWhite,
                      fontFamily: AppConstants.fontPoppinsRegular),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: AppConstants.clrLightGreyTxt,
                  activeColor: AppConstants.clrSkyBlue,
                  inactiveTrackColor: AppConstants.clrLightGreyTxt,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "${AppConstants.shareTo}:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: AppConstants.mediumFontSize14,
                      color: AppConstants.clrWhite,
                      fontFamily: AppConstants.fontPoppinsRegular),
                ),
                Row(
                  children: [
                    Image.asset(AppConstants.wechatLogo, height: 45, width: 45),
                    const SizedBox(width: 15),
                    Image.asset(AppConstants.loginLogo, height: 45, width: 45),
                    const SizedBox(width: 15),
                    Image.asset(AppConstants.linkLogo, height: 45, width: 45)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: 40,
                    //  width: AppConstants.displayWidth(context) * 0.45,
                    onTap: () {
                      // Navigator.pop(context);
                    },
                    textColor: AppConstants.clrWhite,
                    radius: 10,
                    color: AppConstants.clrBlack26,
                    text: AppConstants.dRAFT,
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
                      _con!.postVideoModel.video = widget.videoFile!.path.toString();
                      _con!.postVideoModel.description =videoDec.text.toString();
                      _con!.postVideoModel.videoPrivacy = int.parse(privacyRadioItem.toString());
                      if(isSwitched==true){
                        _con!.postVideoModel.allowDownload = 1;
                      }else{
                        _con!.postVideoModel.allowDownload = 0;
                      }
                      _con!.postVideoModel.hashtags = addTagName.toString().replaceAll('[', '').replaceAll(']', '' );

                      _con!.postVideoApi(context);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicantInfoScreen(),));
                    },
                    textColor: AppConstants.clrWhite,
                    radius: 10,
                    color: AppConstants.clrDialogBtnYesBg,
                    text: AppConstants.pOST,
                    fontSize: AppConstants.mediumFontSize15,
                    fontFamily: AppConstants.fontPoppinsRegular,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tag(String str) {
    return Container(
      decoration: BoxDecoration(
          color: AppConstants.clrWhite, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(right: 9),
      height: 35,
      width: MediaQuery.of(context).size.width * 0.30,
      child: Center(
          child:
              Text(str, style: const TextStyle(color: AppConstants.clrBlack))),
    );
  }

  tagDialog(BuildContext context) {
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppConstants.icTag,
                                  height: 20, width: 20),
                              const SizedBox(width: 8),
                              const Text('Add Tag',
                                  style:
                                      TextStyle(color: AppConstants.clrWhite)),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstants.clrBlue08,
                                borderRadius: BorderRadius.circular(8)),
                            margin: const EdgeInsets.only(right: 8, bottom: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Row(
                              children: const [
                                Text('Food',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite)),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.clear,
                                  color: AppConstants.clrWhite,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: tagName.map((e) {
                          return GestureDetector(
                            onTap: (){
                              if(addTagName.contains(e)){
                                addTagName.remove(e);
                              }else{
                                addTagName.add(e);
                              }
                              setState1(() { });
                              print('addTagName  ${addTagName.toString()}');

                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                //    width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: addTagName.contains(e)?AppConstants.clrBlue08:AppConstants.clrBlack,
                                    borderRadius: BorderRadius.circular(8)),
                                margin:
                                    const EdgeInsets.only(right: 10, bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Row(
                                  children: [
                                    Text(e,
                                        style: const TextStyle(
                                            color: AppConstants.clrWhite)),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.clear,
                                        color: AppConstants.clrWhite, size: 20)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  whoCanViewDialog(BuildContext context) {
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
              builder: (BuildContext context,  setState3) {
                return Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppConstants.whoCanViewThisVideo,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            color: AppConstants.clrWhite,
                            fontFamily: AppConstants.fontPoppinsRegular),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppConstants.clrRadioOffBtn,
                            disabledColor: AppConstants.clrRadioOffBtn),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: privacyRadioItem,
                          title: Text(AppConstants.publicVisibleToEveryone,
                              style: TextStyle(
                                  color: privacyRadioItem == "1"
                                      ? AppConstants.clrSkyBlueTxt
                                      : AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize16,
                                  fontFamily: AppConstants.fontPoppinsRegular)),
                          value: '1',
                          activeColor: AppConstants.clrSkyBlueTxt,
                          onChanged: (val) {
                            setState3(() {
                              privacyRadioItem = val.toString();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppConstants.clrRadioOffBtn,
                            disabledColor: AppConstants.clrRadioOffBtn),
                        child: RadioListTile(
                          groupValue: privacyRadioItem,
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppConstants.clrSkyBlueTxt,
                          title: Text(AppConstants.mutualForDonatedFollowerOnly,
                              style: TextStyle(
                                  color: privacyRadioItem == "2"
                                      ? AppConstants.clrSkyBlueTxt
                                      : AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize16,
                                  fontFamily: AppConstants.fontPoppinsRegular)),
                          value: '2',
                          onChanged: (val) {
                            setState3(() {
                              privacyRadioItem = val.toString();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppConstants.clrRadioOffBtn,
                            disabledColor: AppConstants.clrRadioOffBtn),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: privacyRadioItem,
                          title: Text(AppConstants.privateVisibleToMeOnly,
                              style: TextStyle(
                                  color: privacyRadioItem == "3"
                                      ? AppConstants.clrSkyBlueTxt
                                      : AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize16,
                                  fontFamily: AppConstants.fontPoppinsRegular)),
                          value: '3',
                          activeColor: AppConstants.clrSkyBlueTxt,
                          onChanged: (val) {
                            setState3(() {
                              privacyRadioItem = val.toString();
                            });
                            Navigator.pop(context);
                          },
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


  postVideoRequestDialog(BuildContext context) {
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
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => MyVideoScreen()));
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
                        cameras = await ca.availableCameras();
                      } on ca.CameraException catch (e) {
                        print('Error in fetching the cameras: $e');
                      }
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen('PostVideo')));

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

// selectedDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: const EdgeInsets.symmetric(horizontal: 10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           backgroundColor: AppConstants.clrDialogBg,
//           child: StatefulBuilder(
//             builder: (BuildContext context,  setState2) {
//               return Container(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children:  [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 15),
//                       child: Text(
//                         AppConstants.whoCanViewThisVideo,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             fontSize: AppConstants.mediumFontSize14,
//                             color: AppConstants.clrWhite,
//                             fontFamily: AppConstants.fontPoppinsRegular),
//                       ),
//                     ),
//                     Theme(
//                       data: ThemeData(
//                           unselectedWidgetColor: AppConstants.clrRadioOffBtn,
//                           disabledColor: AppConstants.clrRadioOffBtn),
//                       child: RadioListTile(
//                         contentPadding: EdgeInsets.zero,
//                         groupValue: videoRadioItem,
//                         title: Text(AppConstants.currentlyAvailable,
//                             style: TextStyle(
//                                 color: videoRadioItem == "Item 1"
//                                     ? AppConstants.clrSkyBlue
//                                     : AppConstants.clrWhite,
//                                 fontSize: AppConstants.mediumFontSize16,
//                                 fontFamily: AppConstants.fontPoppinsRegular)),
//                         value: 'Item 1',
//                         activeColor: AppConstants.clrSkyBlue,
//                         onChanged: (val) {
//                           setState(() {
//                             videoRadioItem = val.toString();
//                           });
//                         },
//                       ),
//                     ),
//                     Theme(
//                       data: ThemeData(
//                           unselectedWidgetColor: AppConstants.clrRadioOffBtn,
//                           disabledColor: AppConstants.clrRadioOffBtn),
//                       child: RadioListTile(
//                         groupValue: videoRadioItem,
//                         contentPadding: EdgeInsets.zero,
//                         activeColor: AppConstants.clrSkyBlue,
//                         title: Text(AppConstants.unavailable,
//                             style: TextStyle(
//                                 color: videoRadioItem == "Item 2"
//                                     ? AppConstants.clrSkyBlue
//                                     : AppConstants.clrWhite,
//                                 fontSize: AppConstants.mediumFontSize16,
//                                 fontFamily: AppConstants.fontPoppinsRegular)),
//                         value: 'Item 2',
//                         onChanged: (val) {
//                           setState(() {
//                             videoRadioItem = val.toString();
//                           });
//                         },
//                       ),
//                     ),
//                     Theme(
//                       data: ThemeData(
//                           unselectedWidgetColor: AppConstants.clrRadioOffBtn,
//                           disabledColor: AppConstants.clrRadioOffBtn),
//                       child: RadioListTile(
//                         contentPadding: EdgeInsets.zero,
//                         groupValue: videoRadioItem,
//                         title: Text(AppConstants.partiallyAvailable,
//                             style: TextStyle(
//                                 color: videoRadioItem == "Item 3"
//                                     ? AppConstants.clrSkyBlue
//                                     : AppConstants.clrWhite,
//                                 fontSize: AppConstants.mediumFontSize16,
//                                 fontFamily: AppConstants.fontPoppinsRegular)),
//                         value: 'Item 3',
//                         activeColor: AppConstants.clrSkyBlue,
//                         onChanged: (val) {
//                           setState(() {
//                             videoRadioItem = val.toString();
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       });
// }

}
