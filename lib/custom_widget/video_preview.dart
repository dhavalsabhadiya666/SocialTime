import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  String videoUrl;
   VideoPreview(this.videoUrl,{Key? key}) : super(key: key);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        widget.videoUrl)
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
    return SafeArea(
      child: Scaffold(
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
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: AppConstants.clrWhite,
                  borderRadius: BorderRadius.circular(08)),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,color: AppConstants.clrBlack),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
