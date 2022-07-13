import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/screen/me/post_video.dart';
import 'package:pinmetar_app/utils/constants.dart';
// import 'package:tapioca/tapioca.dart';
import 'package:video_player/video_player.dart';

class PreviewScreen extends StatefulWidget {
  String? openScreen;
  final File? videoFile;

   PreviewScreen(this.openScreen,{this.videoFile});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {

  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    print('imageFile  ${widget.videoFile.toString()}');
    //
    _controller = VideoPlayerController.file(
       widget.videoFile!)
      ..initialize().then((_) {
        _controller!.play();
        _controller!.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // width: _controller!.value.size.width ?? 0,
                // height: _controller!.value.size.height ?? 0,
                child:_controller!.value.isInitialized?VideoPlayer(_controller!):Container(),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //padding: const EdgeInsets.all(10),
            // decoration: const BoxDecoration(
            //     image: DecorationImage(image: AssetImage(AppConstants.videoImageTemp), fit: BoxFit.cover)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                //  _controller!.dispose();
                              },
                              icon: const Icon(Icons.arrow_back,
                                  color: AppConstants.clrWhite)),
                        ),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.width * 0.15),
                      GestureDetector(
                          onTap:(){

                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.icFlip,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.trim,
                                style: TextStyle(
                                    fontSize:
                                    AppConstants.mediumFontSize12,
                                    color: AppConstants.clrWhite),
                              )
                            ],
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () async {
                           print('widget.videoFile!.path  ${widget.videoFile!.path}');
                           // try {
                           //   final tapiocaBalls = [
                           //     TapiocaBall.filter(Filters.pink),
                           //     //TapiocaBall.imageOverlay(imageBitmap, 300, 300),
                           //     TapiocaBall.textOverlay(
                           //         "text", 100, 10, 100, Color(0xffffc0cb)),
                           //   ];
                           //   final cup = Cup(Content(widget.videoFile!.path), tapiocaBalls);
                           //   cup.suckUp(widget.videoFile!.path).then((_) async {
                           //     print("finished");
                           //     GallerySaver.saveVideo(widget.videoFile!.path).then((bool? success) {
                           //       print(success.toString());
                           //     });
                           //   //  final currentState = navigatorKey.currentState;
                           //    // if (currentState != null) {
                           //       // currentState.push(
                           //       //   MaterialPageRoute(builder: (context) =>
                           //       //       VideoScreen(path)),
                           //       // );
                           //  //   }
                           //
                           //   });
                           // } on PlatformException {
                           //   print("error!!!!");
                           // }
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.icFilters,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.filters,
                                style: TextStyle(
                                    fontSize:
                                    AppConstants.mediumFontSize12,
                                    color: AppConstants.clrWhite),
                              )
                            ],
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.icTextAlphabet,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.text,
                                style: TextStyle(
                                    fontSize:
                                    AppConstants.mediumFontSize12,
                                    color: AppConstants.clrWhite),
                              )
                            ],
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.icFrame,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.strSticker,
                                style: TextStyle(
                                    fontSize:
                                    AppConstants.mediumFontSize12,
                                    color: AppConstants.clrWhite),
                              )
                            ],
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pushReplacement(
                      //         MaterialPageRoute(
                      //           builder: (context) => CapturesScreen(
                      //             imageFileList: fileList,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     child: Text('Go to all captures'),
                      //     style: TextButton.styleFrom(
                      //       primary: Colors.black,
                      //       backgroundColor: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Image.asset(AppConstants.userProfile),
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                        height: 45,
                        width: AppConstants.displayWidth(context) * 0.35,
                        onTap: () {
                          //_controller!.pause();
                          //  _controller!.dispose();
                          if(widget.openScreen=='PostVideo'){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => PostVideoScreen(widget.videoFile)));
                          }else{
                            Navigator.pop(context,widget.videoFile);
                            Navigator.pop(context,widget.videoFile);
                          }
                        },
                        radius: 10,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        text: AppConstants.finish,
                        textColor: AppConstants.clrWhite,
                        color: AppConstants.clrDialogBtnYesBg,
                        fontWeight: FontWeight.normal,
                        icon: false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),


    );
  }
}
