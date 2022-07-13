
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/model/gallery_model.dart';
import 'package:pinmetar_app/repository/gallery_repository.dart' as gallery;

class GalleryController extends ControllerMVC {


  List<GalleryDataModel>? galleryDataModel =[];

  Future<void> getGalleryListApi() async {
    // FocusScope.of(context).unfocus();
    showLoader();
    await gallery.getGalleryListApi().then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            galleryDataModel = value.data!;
          });

        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      hideLoader();
      print('catchError galleryDataModel ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
  }

}