
// import 'package:flutter/material.dart';
//
// import 'package:amap_flutter_map/amap_flutter_map.dart';
// import 'package:amap_flutter_base/amap_flutter_base.dart';

// class ShowMapPage extends BasePage {
//   ShowMapPage(String title, String subTitle) : super(title, subTitle);
//   @override
//   Widget build(BuildContext context) {
//     return _ShowMapPageBody();
//   }
// }

// class ShowMapPageBody extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => ShowMapPageState();
// }
//
// class ShowMapPageState extends State<ShowMapPageBody> {
//   static const CameraPosition _kInitialPosition = CameraPosition(
//     target: LatLng(39.909187, 116.397451),
//     zoom: 10.0,
//   );
//   List<Widget> _approvalNumberWidget = [];
//   @override
//
//
//
//   Widget build(BuildContext context) {
//
//
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child:  AMapWidget(
//             apiKey: const AMapApiKey(androidKey: 'ac2b0feb593641537643bd8c9d0c4b80'),
//             initialCameraPosition: _kInitialPosition,
//             onMapCreated: onMapCreated,
//           ),
//         ),
//         Positioned(
//             right: 10,
//             bottom: 15,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: _approvalNumberWidget),
//             ))
//       ],
//     );
//   }
//
//   AMapController? _mapController;
//   void onMapCreated(AMapController controller) {
//     setState(() {
//       _mapController = controller;
//       getApprovalNumber();
//     });
//   }
//
//   /// 获取审图号
//   void getApprovalNumber() async {
//     //普通地图审图号
//     String? mapContentApprovalNumber =
//     await _mapController?.getMapContentApprovalNumber();
//     //卫星地图审图号
//     String? satelliteImageApprovalNumber =
//     await _mapController?.getSatelliteImageApprovalNumber();
//     setState(() {
//       if (null != mapContentApprovalNumber) {
//         _approvalNumberWidget.add(Text(mapContentApprovalNumber));
//       }
//       if (null != satelliteImageApprovalNumber) {
//         _approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
//       }
//     });
//     print('地图审图号（普通地图）: $mapContentApprovalNumber');
//     print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
//   }
// }



import 'package:a_flutter_amap/a_flutter_amap.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';

class AMapWidget extends StatefulWidget {
  double? latitude;
  double? longitude;


  AMapWidget(this.latitude,this.longitude);
  @override
  _AMapWidgetState createState() => _AMapWidgetState();
}

class _AMapWidgetState extends State<AMapWidget> {
   AMapViewController? controller;
   final CameraPosition _cameraPosition = CameraPosition(
      tilt: 15.0,
      zoom: 5.0,
      bearing: 300.0,
      target: LatLng(latitude: 39.694, longitude: 116.104917));

  @override
  void initState() {
    super.initState();
    controller = AMapViewController();

    // _cameraPosition = CameraPosition(
    //     tilt: 5.0,
    //     zoom: 10.0,
    //     bearing: 5.0,
    //     target: LatLng(latitude: widget.latitude!, longitude: widget.latitude!));

 //  controller.setAndroidBound([LatLng(latitude: widget.latitude!, longitude: widget.latitude!)]);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        body: Stack(
          children: [
            AMapView(
              controller: controller,
              autoLocateAfterInit: true,
              showLocationButton: true,
              mapLanguage: MapLanguage.CHINESE,
              showMapText: true,
              defaultCameraPosition: _cameraPosition,
              showCompass: true,
              androidBound: [
                LatLng(latitude: 39.694, longitude: 116.104917),
                LatLng(latitude: 40.377269, longitude: 117.031672),
              ],
              iOSBound: IosBound(
                latLng: LatLng(latitude: 29.546073, longitude: 106.539373),
                latitudeDelta: 1.5,
                longitudeDelta: 2.5,
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
                  icon: const Icon(Icons.arrow_back,color: AppConstants.clrBlack,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )

            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {
            //           controller.getLogoPosition().then((value){
            //             print('getLogoPosition  ${value.toString()}');
            //           });
            //           controller.setAndroidBound([
            //             LatLng(latitude: 29.546073, longitude: 106.539373),
            //             LatLng(latitude: 29.578474, longitude: 106.569929),
            //           ]);
            //         },
            //         child: Text('Android重庆'),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
