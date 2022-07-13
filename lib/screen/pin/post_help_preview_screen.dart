
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinmetar_app/controllers/pin_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PostHelpPreviewScreen extends StatefulWidget {
  @override
  _PostHelpPreviewScreenState createState() => _PostHelpPreviewScreenState();
}

class _PostHelpPreviewScreenState extends StateMVC<PostHelpPreviewScreen> {
  PinController? _con;
  _PostHelpPreviewScreenState(): super(PinController()){
    _con = controller as PinController;
  }
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerCenterRight;

  bool isConfetti = false;
  Uint8List? videoThumbnail;
  //String? videoThumbnailFile;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 5));


    getVideoThumbnail();
  }

  getVideoThumbnail() async {
    if(postFillInPassModel.media != null){
      if( postFillInPassModel.media!.split('.').last.toString().toLowerCase() =='mp4'){
        videoThumbnail = await VideoThumbnail.thumbnailData(
          video: postFillInPassModel.media!,
          imageFormat: ImageFormat.PNG,
          maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 50,
        );
        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/image.png').create();
        file.writeAsBytesSync(videoThumbnail!);
        postFillInPassModel.thumbnail = file.path.toString();

        setState(() { });
        print('videoThumbnail file  ${file.path.toString()}');
        print('videoThumbnail   ${videoThumbnail}');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerTopCenter.dispose();
    _controllerCenterRight.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,
                                  size: 30, color: AppConstants.clrWhite),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              AppConstants.postHelpPreview,
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontSize: AppConstants.mediumFontSize20,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                              AppConstants.editImage,
                              color: AppConstants.clrWhite,
                              width: 22,
                              height: 22,
                            )),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                                child: const Icon(
                              Icons.clear_sharp,
                              color: AppConstants.clrWhite,
                              size: 25,
                            )),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        AppConstants.step3Of3PostHelpPreview,
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: AppConstants.mediumFontSize12,
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
                                  color: AppConstants.clrButtonGreen),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppConstants.clrLightGreyTxt),
                                color: AppConstants.clrButtonGreen),
                            child: const Center(
                              child: Text('3',
                                  style: TextStyle(
                                      color: AppConstants.clrWhite,
                                      fontFamily: AppConstants.fontPoppinsRegular,
                                      fontSize: AppConstants.mediumFontSize20,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                          color: AppConstants.clrBlack26,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.45,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: postFillInPassModel.media ==null
                                    ? const DecorationImage(
                                  image: AssetImage(AppConstants.previewImage),
                                  fit: BoxFit.cover,
                                ): videoThumbnail != null?DecorationImage(
                                  image: MemoryImage(videoThumbnail!),
                                  fit: BoxFit.cover,
                                ):  DecorationImage(
                                  image: FileImage(File(postFillInPassModel.media.toString())),
                                  fit: BoxFit.cover,
                                )),
                          ),
                           SizedBox(height: 15),
                           Text(
                             postFillInPassModel.title.toString(),
                            style: const TextStyle(
                                color: AppConstants.clrWhite,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize17,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                           Text(
                             postFillInPassModel.time.toString(),
                            style: const TextStyle(
                                color: AppConstants.clrDarkGreyText,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize12),
                          ),
                          const SizedBox(height: 20),
                           Text(
                             postFillInPassModel.location.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppConstants.clrWhite,

                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize13),
                          ),
                          const SizedBox(height: 20),
                           Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text(
                              postFillInPassModel.comment.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Center(
                              child: CustomButton(
                                  height: 40,
                                  width: AppConstants.displayWidth(context) * 0.35,
                                  onTap: () {
                                    setState(() {
                                      isConfetti = !isConfetti;
                                    });
                                    if (isConfetti == true) {
                                      _controllerTopCenter.play();
                                      _controllerCenterRight.play();
                                    }
                                    Future.delayed(const Duration(seconds: 1)).then((value){
                                      print('postFillInPassModel  ${postFillInPassModel.toJson()}');
                                      _con!.postFillInApi(context);
                                    });
                                  },
                                  radius: 40,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  fontSize: AppConstants.mediumFontSize16,
                                  text: AppConstants.post,
                                  textColor: AppConstants.clrWhite,
                                  color: AppConstants.clrDialogBtnYesBg,
                                  fontWeight: FontWeight.w700,
                                  icon: false),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
                isConfetti == true ? Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: _controllerTopCenter,
                    blastDirection: 0, // radial value - RIGHT
                    emissionFrequency: 0.3,
                    minimumSize: const Size(9, 9), // set the minimum potential size for the confetti (width, height)
                    maximumSize: const Size(9, 9),// set the maximum potential size for the confetti (width, height)
                    numberOfParticles: 1,
                    gravity: 0.1,
                  ),
                ) : Container(),
                isConfetti == true ? Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: _controllerCenterRight,
                    blastDirection: pi, // radial value - LEFT
                    particleDrag: 0.05, // apply drag to the confetti
                    emissionFrequency: 0.05, // how often it should emit
                    numberOfParticles: 10 ,// number of particles to emit
                    gravity: 0.05, // gravity - or fall speed
                    minimumSize: const Size(9, 9), // set the minimum potential size for the confetti (width, height)
                    maximumSize: const Size(9, 9),
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink
                    ], // manually specify the colors to be used
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
