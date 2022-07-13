import 'dart:async';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/controllers/home_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/screen/home/member_profile.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:path/path.dart' as pathpac;

class FullVideoScreen extends StatefulWidget {
  String? applicantId;

  FullVideoScreen({this.applicantId, Key? key}) : super(key: key);

  @override
  _FullVideoScreenState createState() => _FullVideoScreenState();
}

class _FullVideoScreenState extends StateMVC<FullVideoScreen> {
  HomeController? _con;

  _FullVideoScreenState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  ScrollController commentListController = ScrollController();
  TextEditingController addCommentController = TextEditingController();
  TextEditingController reportController = TextEditingController();

  // List<AddCommentModel> addCommentModel =[];
  VideoPlayerController? _controller;
  String remoteDownloadPath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!
        .getApplicantDetailApi(widget.applicantId.toString(), true)
        .then((value) {
      _controller = VideoPlayerController.network(
          _con!.applicantDetailData.profileVideo.toString())
        ..initialize().then((_) {
          _controller!.play();
          _controller!.setLooping(true);
          // Ensure the first frame is shown after the video is initialized
          setState(() {});
        });
    });

    _con!.getReviewListApi(widget.applicantId.toString(), 1);
    _checkPermission();

  }
  Future<bool> _checkPermission() async {
    if (TargetPlatform.android == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<File> createFileDownloadUrl(String ticketsUrl) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");

    try {
      final url = ticketsUrl.toString();
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);


      // Directory documentDirectory;
      // String newPath = "";
      // if (Platform.isIOS) {
      //   print('In ios================');
      //   documentDirectory = await getApplicationDocumentsDirectory();
      // } else {
      //   print('In android================');
      //   documentDirectory = (await getExternalStorageDirectory())!;
      //   List<String> paths = documentDirectory.path.split("/");
      //   for (int x = 1; x < paths.length; x++) {
      //     String folder = paths[x];
      //     if (folder != "Android") {
      //       newPath += "/" + folder;
      //     } else {
      //       break;
      //     }
      //   }
      // }
      // Directory imageDir;
      // PermissionStatus permission =
      // await Permission.manageExternalStorage.request();
      // if (permission.isGranted == true) {
      //   imageDir = await new Directory('$newPath/Pinmetar');
      // } else {
      //   imageDir =
      //   await new Directory('${documentDirectory.path}/Pinmetar');
      // }
      // if (!await imageDir.exists()) {
      //   await imageDir.create(recursive: true);
      // }



      // final path = Directory((await getExternalStorageDirectory())!.path + '/Pinmetar');
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   await Permission.storage.request();
      // }
      // if ((await path.exists())){
      //   // TODO:
      //   print("exist");
      // }else{
      //   // TODO:
      //   print("not exist");
      //   path.create();
      // }

      String dir = (await getTemporaryDirectory()).path;
      File file = File("${dir}/$filename");
      print('file path---  ${file.path.toString()}');

      await file.writeAsBytes(bytes);
      completer.complete(file);
      hideLoader();
    } catch (e) {
     // throw Exception('Error parsing asset file!  ${e}');
      hideLoader();
      print('Error parsing asset file!  ${e}');
    }
    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppConstants.clrBlack,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: _controller != null
                    ? VideoPlayer(_controller!)
                    : Container(),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     image: const DecorationImage(
            //         image: AssetImage(AppConstants.videoProfile),
            //         fit: BoxFit.cover)),
            child: Stack(
              children: [
                IconButton(
                  padding: const EdgeInsets.only(top: 35, left: 15),
                  icon: const Icon(Icons.arrow_back,
                      color: AppConstants.clrWhite),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MemberProfile(widget.applicantId.toString()),
                                            ));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: _con!.applicantDetailData.profileImage ==null ||_con!.applicantDetailData.profileImage ==''?
                                        const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    AppConstants.userProfile),
                                                fit: BoxFit.cover)):   BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    _con!.applicantDetailData.profileImage.toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                        _con!.applicantDetailData.name
                                            .toString(),
                                        style: const TextStyle(
                                            color: AppConstants.clrWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(_con!.applicantDetailData.title.toString(),
                                      style: const TextStyle(
                                          color: AppConstants.clrWhite,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(AppConstants.gifHeart,
                                    height: 60, width: 50)),
                            GestureDetector(
                                onTap: () {
                                  _con!
                                      .likeApplicantApi(
                                          widget.applicantId.toString())
                                      .then((value) {
                                    _con!
                                        .getApplicantDetailApi(
                                            widget.applicantId.toString(),
                                            false)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  });
                                },
                                child: const Icon(Icons.favorite,
                                    color: Colors.red)),
                            const SizedBox(height: 5),
                            Text(_con!.applicantDetailData.likes.toString(),
                                style: const TextStyle(
                                    fontSize: 12, color: AppConstants.clrWhite),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  _con!
                                      .addFollowerApi(
                                          widget.applicantId.toString())
                                      .then((value) {
                                    _con!
                                        .getApplicantDetailApi(
                                            widget.applicantId.toString(),
                                            false)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  });
                                },
                                child: Image.asset(AppConstants.userAdd,
                                    height: 25)),
                            const SizedBox(height: 5),
                            Text(
                                '${_con!.applicantDetailData.followers.toString()}\nFollower',
                                style: const TextStyle(
                                    fontSize: 12, color: AppConstants.clrWhite),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      // isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24.0),
                                            topRight: Radius.circular(24.0)),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return sharedBottomSheet();
                                      });
                                },
                                child: Image.asset(AppConstants.shared,
                                    height: 25)),
                            const SizedBox(height: 5),
                            const Text('182',
                                style: TextStyle(
                                    fontSize: 12, color: AppConstants.clrWhite),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(42.0),
                                            topRight: Radius.circular(42.0)),
                                      ),
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                                      builder: (BuildContext context) {
                                        return addCommentBottomSheet();
                                      });
                                },
                                child: Image.asset(AppConstants.comment,
                                    height: 25)),
                            const SizedBox(height: 5),
                            const Text('283',
                                style: TextStyle(
                                    fontSize: 12, color: AppConstants.clrWhite),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sharedBottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Text(AppConstants.shareTo,
              style: TextStyle(
                  color: AppConstants.clrBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _launchWhatsapp(
                    "https://wa.me/?text=${_con!.applicantDetailData.profileVideo.toString()}");
              },
              child: Column(
                children: [
                  Image.asset(AppConstants.whatsAppLogo, height: 47),
                  const SizedBox(height: 5),
                  const Text(AppConstants.whatsApp,
                      style:
                          TextStyle(color: AppConstants.clrBlack, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                // _launchWhatsapp("https://wa.me/?text=${_con!.applicantDetailData.profileVideo.toString()}");
              },
              child: Column(
                children: [
                  Image.asset(AppConstants.messageRed, height: 47),
                  const SizedBox(height: 5),
                  const Text(AppConstants.message,
                      style:
                          TextStyle(color: AppConstants.clrBlack, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _launchWhatsapp(
                    "sms:?body=${_con!.applicantDetailData.profileVideo.toString()}");
              },
              child: Column(
                children: [
                  Image.asset(AppConstants.smsLogo, height: 47),
                  const SizedBox(height: 5),
                  const Text(AppConstants.sMS,
                      style:
                          TextStyle(color: AppConstants.clrBlack, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _launchWhatsapp(
                    "fb://facewebmodal/f?href=${_con!.applicantDetailData.profileVideo.toString()}");
              },
              child: Column(
                children: [
                  Image.asset(AppConstants.fbMessenger, height: 47),
                  const SizedBox(height: 5),
                  const Text(AppConstants.messenger,
                      style:
                          TextStyle(color: AppConstants.clrBlack, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _launchWhatsapp(
                    "instagram://share?text=${_con!.applicantDetailData.profileVideo.toString()}");
              },
              child: Column(
                children: [
                  Image.asset(AppConstants.instagramLogo, height: 47),
                  const SizedBox(height: 5),
                  const Text(AppConstants.instagram,
                      style:
                          TextStyle(color: AppConstants.clrBlack, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 25),
          height: 1,
          color: AppConstants.clrDivider,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    showLoader();
                    GallerySaver.saveVideo(_con!.applicantDetailData.profileVideo.toString()).then((bool? success) {
                      if(success ==true){
                        createFileDownloadUrl(
                            _con!.applicantDetailData.profileVideo.toString())
                            .then((f) {
                          setState(() {
                            remoteDownloadPath = f.path;
                            print('remoteDownloadPath  ${remoteDownloadPath.toString()}');
                            showReportNotification(
                                remoteDownloadPath
                                    .toString(),
                                pathpac.basenameWithoutExtension(
                                    remoteDownloadPath));
                          });
                        });
                      }else{
                        hideLoader();
                      }
                      setState(() {
                        print('Video is saved --> ${success.toString()}');
                      });
                    });

                  },
                  child: Column(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.clrBlack),
                        child: Center(
                            child: Image.asset(
                          AppConstants.download,
                          height: 30,
                          width: 30,
                        )),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        AppConstants.downloadString,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            color: AppConstants.clrLightGreyTxt),
                      )
                    ],
                  )),
              const SizedBox(width: 30),
              GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: _con!.applicantDetailData.profileVideo
                                .toString()))
                        .then((value) {
                      showToast('Copy Link');
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.clrBlack),
                        child: Center(
                            child: Image.asset(
                          AppConstants.copyLink,
                          height: 30,
                          width: 30,
                        )),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        AppConstants.copyLinkText,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            color: AppConstants.clrLightGreyTxt),
                      )
                    ],
                  )),
              const SizedBox(width: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    reportDialog(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.clrBlack),
                        child: Center(
                            child: Image.asset(
                          AppConstants.report,
                          height: 30,
                          width: 30,
                        )),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        AppConstants.reportString,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize12,
                            color: AppConstants.clrLightGreyTxt),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget addCommentBottomSheet() {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40))),
      child: StatefulBuilder(builder: (BuildContext context, updateVal) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppConstants.review,
                    style: TextStyle(
                        color: AppConstants.clrBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppConstants.clrBlack,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: _con!.reviewListDataModel.data == null ||_con!.reviewListDataModel.data.toString() == '[]'
                  ? Container(
                      height: MediaQuery.of(context).size.width,
                      child: const Center(
                          child: Text('No Reviews',
                              style:
                                  TextStyle(color: AppConstants.clrGreyText))),
                    )
                  : ListView.builder(
                      controller: commentListController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _con!.reviewListDataModel.data!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: _con!.reviewListDataModel
                                                .data![index].profileImage ==
                                            null
                                        ? const DecorationImage(
                                            image: AssetImage(
                                                AppConstants.userProfile),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: NetworkImage(_con!
                                                .reviewListDataModel
                                                .data![index]
                                                .profileImage
                                                .toString()),
                                            fit: BoxFit.cover)),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        _con!.reviewListDataModel.data![index]
                                                .name
                                                .toString() +
                                            ': ',
                                        style: const TextStyle(
                                            color: AppConstants.clrBlack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _con!.reviewListDataModel.data![index]
                                            .message
                                            .toString(),
                                        style: const TextStyle(
                                            color: AppConstants.clrBlack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                 timeago.format( DateFormat("yyyy-MM-dd HH:mm:ss").parse(_con!.reviewListDataModel.data![index].updatedAt!.toString(), true)).toString(),
                                    style: const TextStyle(
                                        color: AppConstants.clrGreyText,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 15,
                  right: 15),
              child: Container(
                color: AppConstants.clrTransparent,
                margin: const EdgeInsets.only(bottom: 10),
                height: 55,
                child: TextField(
                  controller: addCommentController,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(AppConstants.sticker,
                            height: 10, width: 10),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _con!
                              .addReviewApi(widget.applicantId.toString(),
                                  addCommentController.text.toString())
                              .then((value) {
                            addCommentController.clear();
                            _con!
                                .getReviewListApi(
                                    widget.applicantId.toString(), 1)
                                .then((value) {
                              updateVal(() {});
                            });
                          });
                          updateVal(() {
                            print('eggrg');
                          });
                        },
                        child: const Icon(Icons.send,
                            color: AppConstants.clrButtonGreen),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppConstants.clrBorderGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppConstants.clrBorderGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      hintStyle:
                          const TextStyle(color: AppConstants.clrHintText),
                      hintText: "Write review here...",
                      fillColor: Colors.white70),
                  onTap: () {
                    setState(() {
                      commentListController.animateTo(
                          commentListController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    });
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  reportDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(AppConstants.enterReport,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize16,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite,
                            fontWeight: FontWeight.w600)),
                  ),
                  TextFormField(
                    controller: reportController,
                    maxLines: 5,
                    style: TextStyle(color: AppConstants.clrWhite),
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
                      labelText: 'Report',
                      labelStyle: const TextStyle(
                          fontSize: AppConstants.mediumFontSize16,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrDarkGreyText),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                            height: 50,
                            onTap: () => Navigator.pop(context),
                            padding: const EdgeInsets.all(10),
                            radius: 12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize15,
                            text: AppConstants.cancel,
                            textColor: AppConstants.clrWhite,
                            color: AppConstants.clrDialogBtnNoBg,
                            icon: false),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                            height: 50,
                            onTap: () {
                              Navigator.pop(context);
                               _con!.saveMediaReportApi(widget.applicantId.toString(), _con!.applicantDetailData.profileVideo.toString(), reportController.text.toString());

                           },
                            padding: const EdgeInsets.all(10),
                            radius: 12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize15,
                            text: AppConstants.save,
                            textColor: AppConstants.clrWhite,
                            color: AppConstants.clrDialogBtnYesBg,
                            icon: false),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _launchWhatsapp(String url2) async {
    var url = url2;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showReportNotification(filepath, appName) async {
    await _showNotification(filepath, appName);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _showNotification(String filepath, String appName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('Notification', 'important notification',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Pinmetar', 'Download Completed', platformChannelSpecifics,
        payload: filepath);
  }
}
