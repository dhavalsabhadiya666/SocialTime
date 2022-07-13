import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/controllers/gallery_controller.dart';
import 'package:pinmetar_app/utils/constants.dart';

class TempVideoScreen extends StatefulWidget {
  const TempVideoScreen({Key? key}) : super(key: key);

  @override
  _TempVideoScreenState createState() => _TempVideoScreenState();
}

class _TempVideoScreenState extends StateMVC<TempVideoScreen> {
  GalleryController? _con;

  _TempVideoScreenState() : super(GalleryController()) {
    _con = controller as GalleryController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getGalleryListApi();
  }


  Future<File> createFileDownloadUrl(String videoUrl) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
showLoader();
    try {
      final url = videoUrl.toString();
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        elevation: 0,
        title: const Text(
          AppConstants.myVideo,
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: _con!.galleryDataModel == null &&
                _con!.galleryDataModel.toString() == '[]'
            ? const Text(
                'Data Not Found',
                style: TextStyle(color: AppConstants.clrGreyText),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _con!.galleryDataModel!.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: (){
                      createFileDownloadUrl(_con!.galleryDataModel![i].media.toString()).then((file) {
                        Navigator.pop(context,file);
                      });
                    },
                    child: Container(
                     // height: MediaQuery.of(context).size.width * 0.45,
                      //width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppConstants.clrBlack26,
                          image:  DecorationImage(
                              image: NetworkImage(_con!.galleryDataModel![i].thumbnail.toString()),fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(AppConstants.play,
                            width: 50, height: 50),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
