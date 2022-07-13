import 'dart:async';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinmetar_app/utils/constants.dart';

class ImagePreview extends StatefulWidget {
  String? imageUrl;

  ImagePreview(this.imageUrl, {Key? key}) : super(key: key);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  String? docFilePath;

  @override
  void initState() {
    super.initState();
    if(widget.imageUrl.toString().split('.').last.toString().toLowerCase() !='jpg' ||  widget.imageUrl.toString().split('.').last.toString().toLowerCase() !='png' ||  widget.imageUrl.toString().split('.').last.toString().toLowerCase() !='jpeg'){
      _checkPermission().then((value) {
        createFileOfPdfUrl().then((value) {
          if (value != null) {
            print('defidggfkll  ${value.path}');
            setState(() {
              docFilePath = value.path.toString();
            });
          }
        });
      });
    }
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

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = widget.imageUrl.toString();
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      File file = File("${dir}/$filename");
      print('file path---  ${file.path.toString()}');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file  createFileOfPdfUrl ! ${e}');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppConstants.clrWhite,
            )),
      ),
      body: widget.imageUrl
                      .toString()
                      .split('.')
                      .last
                      .toString()
                      .toLowerCase() ==
                  'jpg' ||
              widget.imageUrl
                      .toString()
                      .split('.')
                      .last
                      .toString()
                      .toLowerCase() ==
                  'png' ||
              widget.imageUrl
                      .toString()
                      .split('.')
                      .last
                      .toString()
                      .toLowerCase() ==
                  'jpeg'
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.imageUrl.toString()),
                          fit: BoxFit.cover)),
                ),
              ],
            )
          : PDFView(
              filePath: docFilePath.toString(),
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onRender: (_pages) {
                setState(() {
                  // pages = _pages;
                  // isReady = true;
                });
              },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                // _controller.complete(pdfViewController);
              },
              onPageChanged: (int? page, int? total) {
                //  print('page change: $page/$total');
              },
            ),
    );
  }
}
