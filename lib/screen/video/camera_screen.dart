import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/screen/video/preview_screen.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatefulWidget {
  String? openScreen;

  CameraScreen(this.openScreen);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  VideoPlayerController? videoController;

  List<String> timer =["2m", "1m", "30s"];
  Timer? _timer;
  Timer? _videoTimer;
  int _videoStart = 0;
  int _start = 4;

  int isSelectTimer = 1;
  File? _imageFile;
  File? _videoFile;

  // Initial values
  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;
  bool _isVideoCameraSelected = true;
  bool _isRecordingInProgress = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  // Current values
  double _currentZoomLevel = 1.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      if (recentFileName.contains('.mp4')) {
        _videoFile = File('${directory.path}/$recentFileName');
        print('fifisjfidsifidfs   ${_videoFile!.path.toString()}');

        _imageFile = null;
        _startVideoPlayer();
      } else {
        _imageFile = File('${directory.path}/$recentFileName');
        _videoFile = null;
      }

      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<void> _startVideoPlayer() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      await videoController!.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
      await videoController!.setLooping(true);
      await videoController!.play();
    }
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;
    print('jgfijgifigfigi  ${controller!.value.isRecordingVideo.toString()}');
    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }
    try {
      await cameraController!.startVideoRecording();
      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }

    try {
      XFile file = await controller!.stopVideoRecording();
      setState(() {
        _isRecordingInProgress = false;
      });
      return file;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }

    try {
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }

    try {
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    // Hide the status bar in Android
    //   SystemChrome.setEnabledSystemUIOverlays([]);
    // Set and initialize the new camera
    onNewCameraSelected(cameras[1]);
  //  refreshAlreadyCapturedImages();
    super.initState();
  }



  Future<void> startTimer() async {
    const oneSec =  Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
          (Timer timer) async {
            if(_start ==0){
              print('kllklllllllk  $_isRecordingInProgress');
              _timer!.cancel();
              _start --;
              if (_isRecordingInProgress) {
                XFile? rawVideo =
                await stopVideoRecording();
                File videoFile =
                File(rawVideo!.path);
                int currentUnix = DateTime.now()
                    .millisecondsSinceEpoch;
                final directory =
                await getApplicationDocumentsDirectory();
                String fileFormat =
                    videoFile.path.split('.').last;
                _videoFile = await videoFile.copy(
                  '${directory.path}/$currentUnix.$fileFormat',
                );
                print('fifisjfidsifidfs   ${_videoFile!.path.toString()}');
                // _startVideoPlayer();
              } else {
                await startVideoRecording();
              }
            } else {
          setState(() {
            _start--;
          });
        }
        print('start timer --> $_start');
      },
    );
  }

  Future<void> videoStartTimer() async {
    const oneSec =  Duration(seconds: 1);
    _videoTimer =  Timer.periodic(
      oneSec,
          (Timer timer) async {
        print('_videoStart  ${_videoStart.toString()}');
        if (_videoStart == 0) {
          setState(() {
            timer.cancel();
          });

          XFile? rawVideo =
              await stopVideoRecording();
          File videoFile =
          File(rawVideo!.path);
          int currentUnix = DateTime.now()
              .millisecondsSinceEpoch;
          final directory =
              await getApplicationDocumentsDirectory();
          String fileFormat =
              videoFile.path.split('.').last;
          _videoFile = await videoFile.copy(
            '${directory.path}/$currentUnix.$fileFormat',
          );
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>  PreviewScreen(
                    widget.openScreen,
                    videoFile: _videoFile!,
                    // fileList: allFileList,
                  )));
          print('fifisjfidsifidfs   ${_videoFile!.path.toString()}');
        } else {
          setState(() {
            _videoStart--;
          });
        }

      },
    );
  }



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    videoController?.dispose();
    if(_timer != null){
      _timer!.cancel();
    }
    if(_videoTimer != null){
      _videoTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _isCameraInitialized
            ? Stack(
          fit: StackFit.expand,
              children: [
                AspectRatio(
                    aspectRatio: 1/controller!.value.aspectRatio,
                    child: controller!.buildPreview()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.black87,
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         left: 8.0,
                      //         right: 8.0,
                      //       ),
                      //       child: DropdownButton<ResolutionPreset>(
                      //         dropdownColor: Colors.black87,
                      //         underline: Container(),
                      //         value: currentResolutionPreset,
                      //         items: [
                      //           for (ResolutionPreset preset
                      //               in resolutionPresets)
                      //             DropdownMenuItem(
                      //               child: Text(
                      //                 preset
                      //                     .toString()
                      //                     .split('.')[1]
                      //                     .toUpperCase(),
                      //                 style: TextStyle(
                      //                     color: Colors.white),
                      //               ),
                      //               value: preset,
                      //             )
                      //         ],
                      //         onChanged: (value) {
                      //           setState(() {
                      //             currentResolutionPreset = value!;
                      //             _isCameraInitialized = false;
                      //           });
                      //           onNewCameraSelected(
                      //               controller!.description);
                      //         },
                      //         hint: Text("Select item"),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       right: 8.0, top: 16.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(
                      //         _currentExposureOffset
                      //                 .toStringAsFixed(1) +
                      //             'x',
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: RotatedBox(
                      //     quarterTurns: 3,
                      //     child: Container(
                      //       height: 30,
                      //       child: Slider(
                      //         value: _currentExposureOffset,
                      //         min: _minAvailableExposureOffset,
                      //         max: _maxAvailableExposureOffset,
                      //         activeColor: Colors.white,
                      //         inactiveColor: Colors.white30,
                      //         onChanged: (value) async {
                      //           setState(() {
                      //             _currentExposureOffset = value;
                      //           });
                      //           await controller!
                      //               .setExposureOffset(value);
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // )
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: AppConstants.clrWhite)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.15),
                      GestureDetector(
                          onTap: _isRecordingInProgress
                              ? () async {
                                  if (controller!.value.isRecordingPaused) {
                                    await resumeVideoRecording();
                                  } else {
                                    await pauseVideoRecording();
                                  }
                                }
                              : () {
                                  setState(() {
                                    _isCameraInitialized = false;
                                  });
                                  onNewCameraSelected(cameras[
                                      _isRearCameraSelected ? 0 : 1]);
                                  setState(() {
                                    _isRearCameraSelected =
                                        !_isRearCameraSelected;
                                  });
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
                                AppConstants.flip,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize12,
                                    color: AppConstants.clrWhite),
                              )
                            ],
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            startTimer().then((value) async {
                              print('start timer --> $_start');

                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.icTimer,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.timer,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize12,
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
                                AppConstants.icFilters,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.filters,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize12,
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
                                AppConstants.icMagicPen,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                AppConstants.beauty,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize12,
                                    color: AppConstants.clrWhite),
                              )
                            ],
                          )),

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Slider(
                      //         value: _currentZoomLevel,
                      //         min: _minAvailableZoom,
                      //         max: _maxAvailableZoom,
                      //         activeColor: Colors.white,
                      //         inactiveColor: Colors.white30,
                      //         onChanged: (value) async {
                      //           setState(() {
                      //             _currentZoomLevel = value;
                      //           });
                      //           await controller!.setZoomLevel(value);
                      //         },
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 8.0),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //           color: Colors.black87,
                      //           borderRadius:
                      //               BorderRadius.circular(10.0),
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(
                      //             _currentZoomLevel.toStringAsFixed(1) +
                      //                 'x',
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.55),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Image.asset(
                                      AppConstants.icLayer,
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Effects',
                                      style: TextStyle(
                                          fontSize:
                                              AppConstants.mediumFontSize12,
                                          color: AppConstants.clrWhite),
                                    )
                                  ],
                                )),
                            // InkWell(
                            //   onTap: (){},
                            //   // onTap: _isRecordingInProgress
                            //   //     ? () async {
                            //   //         if (controller!
                            //   //             .value.isRecordingPaused) {
                            //   //           await resumeVideoRecording();
                            //   //         } else {
                            //   //           await pauseVideoRecording();
                            //   //         }
                            //   //       }
                            //   //     : () {
                            //   //         setState(() {
                            //   //           _isCameraInitialized = false;
                            //   //         });
                            //   //         onNewCameraSelected(cameras[
                            //   //             _isRearCameraSelected ? 1 : 0]);
                            //   //         setState(() {
                            //   //           _isRearCameraSelected =
                            //   //               !_isRearCameraSelected;
                            //   //         });
                            //   //       },
                            //   child: Stack(
                            //     alignment: Alignment.center,
                            //     children: [
                            //       const Icon(
                            //         Icons.circle,
                            //         color: Colors.black38,
                            //         size: 60,
                            //       ),
                            //       _isRecordingInProgress
                            //           ? controller!
                            //                   .value.isRecordingPaused
                            //               ? const Icon(
                            //                   Icons.play_arrow,
                            //                   color: Colors.white,
                            //                   size: 30,
                            //                 )
                            //               : const Icon(
                            //                   Icons.pause,
                            //                   color: Colors.white,
                            //                   size: 30,
                            //                 )
                            //           : Icon(
                            //               _isRearCameraSelected
                            //                   ? Icons.camera_front
                            //                   : Icons.camera_rear,
                            //               color: Colors.white,
                            //               size: 30,
                            //             ),
                            //     ],
                            //   ),
                            // ),
                            InkWell(
                              onTap: _isVideoCameraSelected
                                  ? () async {
                                print('111111111');
                                      if (_isRecordingInProgress) {
                                        XFile? rawVideo =
                                            await stopVideoRecording();
                                        File videoFile =
                                            File(rawVideo!.path);
                                        int currentUnix = DateTime.now()
                                            .millisecondsSinceEpoch;
                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        String fileFormat =
                                            videoFile.path.split('.').last;
                                        _videoFile = await videoFile.copy(
                                          '${directory.path}/$currentUnix.$fileFormat',
                                        );
                                        _videoTimer!.cancel();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                            builder: (context) =>  PreviewScreen(
                                              widget.openScreen,
                                           videoFile: _videoFile!,
                                          // fileList: allFileList,
                                        )));
                                        print('fifisjfidsifidfs   ${_videoFile!.path.toString()}');
                                       // _startVideoPlayer();
                                      } else {
                                        print('5555555');
                                        await startVideoRecording();
                                        if(isSelectTimer==0){
                                          setState(() {
                                            _videoStart =120;
                                          });
                                          videoStartTimer();
                                        }else if(isSelectTimer==1) {
                                          setState(() {
                                            _videoStart =60;
                                          });
                                          videoStartTimer();
                                        }else {
                                          setState(() {
                                            _videoStart =30;
                                          });
                                          videoStartTimer();
                                        }

                                      }
                                    }
                                  : () async {
                                print('222222222');
                                      XFile? rawImage = await takePicture();
                                      File imageFile = File(rawImage!.path);

                                      int currentUnix = DateTime.now()
                                          .millisecondsSinceEpoch;

                                      final directory =
                                          await getApplicationDocumentsDirectory();

                                      String fileFormat =
                                          imageFile.path.split('.').last;

                                      print(fileFormat);

                                      await imageFile.copy(
                                        '${directory.path}/$currentUnix.$fileFormat',
                                      );
                                      refreshAlreadyCapturedImages();
                                    },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Icon(
                                  //   Icons.circle,
                                  //   color: _isVideoCameraSelected
                                  //       ? Colors.white
                                  //       : Colors.white38,
                                  //   size: 80,
                                  // ),
                                  // Icon(
                                  //   Icons.circle,
                                  //   color: _isVideoCameraSelected
                                  //       ? Colors.red
                                  //       : Colors.white,
                                  //   size: 65,
                                  // ),
                                  Image.asset(AppConstants.icRecordButton,
                                      height: 65,
                                      width: 65,
                                      color: _isVideoCameraSelected
                                          ? Colors.red
                                          : Colors.white),
                                  _isVideoCameraSelected &&
                                          _isRecordingInProgress
                                      ? const Icon(
                                          Icons.stop_rounded,
                                          color: Colors.white,
                                          size: 32,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap:
                                    // _imageFile != null || _videoFile != null
                                    //     ?
                                        () {
                                            // Navigator.of(context).push(
                                            //   MaterialPageRoute(
                                            //     builder: (context) => const PreviewScreen(
                                            //       widget.openScreen,
                                            //         // imageFile: _videoFile!,
                                            //         // fileList: allFileList,
                                            //         ),
                                            //   ),
                                            // );
                                          },
                                        //: null,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      AppConstants.icImage,
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Upload',
                                      style: TextStyle(
                                          fontSize:
                                              AppConstants.mediumFontSize12,
                                          color: AppConstants.clrWhite),
                                    )
                                  ],
                                )),
                            // InkWell(
                            //   onTap:
                            //       _imageFile != null || _videoFile != null
                            //           ? () {
                            //               Navigator.of(context).push(
                            //                 MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       PreviewScreen(
                            //                     imageFile: _imageFile!,
                            //                     fileList: allFileList,
                            //                   ),
                            //                 ),
                            //               );
                            //             }
                            //           : null,
                            //   child: Container(
                            //     width: 60,
                            //     height: 60,
                            //     decoration: BoxDecoration(
                            //       color: Colors.black,
                            //       borderRadius:
                            //           BorderRadius.circular(10.0),
                            //       border: Border.all(
                            //         color: Colors.white,
                            //         width: 2,
                            //       ),
                            //       image: _imageFile != null
                            //           ? DecorationImage(
                            //               image: FileImage(_imageFile!),
                            //               fit: BoxFit.cover,
                            //             )
                            //           : null,
                            //     ),
                            //     child: videoController != null &&
                            //             videoController!
                            //                 .value.isInitialized
                            //         ? ClipRRect(
                            //             borderRadius:
                            //                 BorderRadius.circular(8.0),
                            //             child: AspectRatio(
                            //               aspectRatio: videoController!
                            //                   .value.aspectRatio,
                            //               child: VideoPlayer(
                            //                   videoController!),
                            //             ),
                            //           )
                            //         : Container(),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,child: Container()),
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 25,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: timer.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isSelectTimer = index;

                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        children: [
                                           Text(timer[index].toString().replaceAll(',', ''),
                                              style:  TextStyle(
                                                  color: isSelectTimer==index? AppConstants.clrWhite:Colors.white60,fontWeight: FontWeight.bold)),
                                          isSelectTimer==index? Container(
                                            height: 5,
                                            width: 5,
                                            decoration: const BoxDecoration(
                                                color: AppConstants.clrWhite,
                                                shape: BoxShape.circle),
                                          ):Container()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,child: Container()),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                _start ==-1 || _start ==0 || _start ==4?Container(height: 0,width: 0,):   Center(child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppConstants.clrWhite,width: 03)),
                    child: Center(child: Text(_start.toString(),style: const TextStyle(fontSize: 30,color: AppConstants.clrWhite,fontWeight: FontWeight.bold)))))
              ],
            )
            : const Center(
                child: Text(
                  'LOADING',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
