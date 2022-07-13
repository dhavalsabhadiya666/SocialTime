import 'package:flutter/material.dart';
import 'package:flutter_pay/flutter_pay.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/home_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/custom_widget/video_preview.dart';
import 'package:pinmetar_app/screen/message/chat_page.dart';
import 'package:pinmetar_app/screen/message/chat_room_page.dart';
import 'package:pinmetar_app/utils/constants.dart';

class MemberProfile extends StatefulWidget {
  String? applicantId;

  MemberProfile(this.applicantId, {Key? key}) : super(key: key);

  @override
  _MemberProfileState createState() => _MemberProfileState();
}

class _MemberProfileState extends StateMVC<MemberProfile> {
  HomeController? _con;

  _MemberProfileState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  FlutterPay flutterPay = FlutterPay();

  String result = "Result will be shown here";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getApplicantDetailApi(widget.applicantId.toString(), true);
  }


  void makePayment(int coins) async {
    List<PaymentItem> items = [
      PaymentItem(name: "test", price: 1.00)
    ];

    flutterPay.setEnvironment(environment: PaymentEnvironment.Test);

    flutterPay.requestPayment(
      googleParameters: GoogleParameters(
        gatewayName: "example",
        gatewayMerchantId: "example_id",
      ),
      appleParameters: AppleParameters(merchantIdentifier: "merchant.flutterpay.example"),
      currencyCode: "USD",
      countryCode: "US",
      paymentItems: items,
    ).then((value) {
      if(value.isNotEmpty){
         _con!.purchaseCoinsApi(context, _con!.applicantDetailData.applicantId.toString(), coins).then((value) {
          _con!.getApplicantDetailApi(widget.applicantId.toString(), false);
         });
      }
      print('payment --> ${value.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(AppConstants.memberProfileVideoList,
            style: TextStyle(
                color: AppConstants.clrWhite, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: _con!.applicantDetailData.userId != null
            ? Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: _con!.applicantDetailData.userId != null &&
                                    _con!.applicantDetailData.profileImage ==
                                        null
                                ? const DecorationImage(
                                    image: AssetImage(AppConstants.userProfile),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: NetworkImage(_con!
                                        .applicantDetailData.profileImage
                                        .toString()),
                                    fit: BoxFit.cover)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Text(_con!.applicantDetailData.name.toString(),
                            style: const TextStyle(
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                    Row(
                      children: [
                        contactWidget(
                            AppConstants.privateFan,
                            _con!.applicantDetailData.followers.toString(),
                            'Private Fans', () {
                          joinChatDialog(context);
                        }),
                        const SizedBox(width: 10),
                        contactWidget(
                            AppConstants.likes,
                            _con!.applicantDetailData.likes.toString(),
                            'Likes',
                            () {}),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        contactWidget(
                            AppConstants.donate,
                            'Donate',
                            '',
                            () => donateDialog(
                                    context,
                                    _con!.applicantDetailData
                                        .coinsToBecomeFriend!, () {

                                _con!.donateDialogApi(
                                    context,
                                    _con!.applicantDetailData.applicantId
                                        .toString()).then((value) {
                                          if(_con!.purchaseCoins ==0){
                                            chooseOptionDialog(context);
                                          }
                                });



                                })),
                        SizedBox(width: 10),
                        contactWidget(AppConstants.chat, 'Chat', '', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              ));
                        }),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(AppConstants.videos,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                    _con!.applicantDetailData.videos == null &&
                            _con!.applicantDetailData.videos.toString() == '[]'
                        ? Container(
                            height: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: Text('Data Not Found',
                                    style: TextStyle(
                                        color: AppConstants.clrGreyText))),
                          )
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            itemCount: _con!.applicantDetailData.videos!.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPreview(_con!.applicantDetailData
                                      .videos![index].video.toString())));
                               //   donateToBecomeFanDialog(context);
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: _con!.applicantDetailData
                                                  .videos![index].thumbnail ==
                                              null
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  AppConstants.videoImage),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: NetworkImage(_con!
                                                  .applicantDetailData
                                                  .videos![index]
                                                  .thumbnail
                                                  .toString()),
                                              fit: BoxFit.cover)),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(AppConstants.play,
                                              height: 35, width: 35)),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: GestureDetector(
                                          onTap: (){
                                            _con!.likeVideoApi(_con!
                                                .applicantDetailData
                                                .videos![index].postVideoId.toString()).then((value) {
                                              _con!.getApplicantDetailApi(widget.applicantId.toString(), false);
                                            });
                                          },
                                          child: Row(
                                            children:  [
                                              const Icon(Icons.favorite,
                                                  color: AppConstants.clrWhite),
                                              const SizedBox(width: 3),
                                              Text( _con!
                                                  .applicantDetailData
                                                  .videos![index].like.toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          AppConstants.clrWhite,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  Widget contactWidget(String image, String val, String dec, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppConstants.clrBlack26)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(image, width: 35, height: 35),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(val,
                      style: const TextStyle(
                          color: AppConstants.clrWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  dec.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(dec,
                              style: const TextStyle(
                                  color: AppConstants.clrBorderGreyColor,
                                  fontSize: 14)),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  joinChatDialog(BuildContext context) {
    bool _value1 = false;
    bool _value2 = false;
    bool _value3 = false;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppConstants.clrDialogBg,
              child:
                  StatefulBuilder(builder: (BuildContext context, setState1) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppConstants.joinChatGroup,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppConstants.clrWhite,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize18),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 50, top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState1(() {
                                        _value1 = !_value1;
                                      });

                                      print('asjhdfbgashjbfasf: $_value1');
                                    },
                                    child: _value1 == false
                                        ? const Icon(
                                            Icons.check_box_outline_blank,
                                            size: 25,
                                            color: AppConstants.clrWhite,
                                          )
                                        : const Icon(Icons.check_box_outlined,
                                            size: 25,
                                            color: AppConstants.clrWhite),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    AppConstants.pianistChatGroup,
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontFamily:
                                            AppConstants.pianistChatGroup,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppConstants.mediumFontSize16),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState1(() {
                                          _value2 = !_value2;
                                        });

                                        print('asjhdfbgashjbfasf: $_value1');
                                      },
                                      child: _value2 == false
                                          ? const Icon(
                                              Icons.check_box_outline_blank,
                                              size: 25,
                                              color: AppConstants.clrWhite,
                                            )
                                          : const Icon(Icons.check_box_outlined,
                                              size: 25,
                                              color: AppConstants.clrWhite),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      AppConstants.violinistChatGroup,
                                      style: TextStyle(
                                          color: AppConstants.clrWhite,
                                          fontFamily:
                                              AppConstants.pianistChatGroup,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              AppConstants.mediumFontSize16),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState1(() {
                                          _value3 = !_value3;
                                        });

                                        print('asjhdfbgashjbfasf: $_value1');
                                      },
                                      child: _value3 == false
                                          ? const Icon(
                                              Icons.check_box_outline_blank,
                                              size: 25,
                                              color: AppConstants.clrWhite,
                                            )
                                          : const Icon(Icons.check_box_outlined,
                                              size: 25,
                                              color: AppConstants.clrWhite),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      AppConstants.chatWithJohnDoePrivately,
                                      style: TextStyle(
                                          color: AppConstants.clrWhite,
                                          fontFamily:
                                              AppConstants.pianistChatGroup,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              AppConstants.mediumFontSize16),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      CustomButton(
                          height: 50,
                          width: AppConstants.displayWidth(context) * 0.8,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoomScreen(),
                                ));
                          },
                          padding: const EdgeInsets.all(10),
                          radius: 12,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          fontSize: AppConstants.mediumFontSize15,
                          text: AppConstants.confirm,
                          textColor: AppConstants.clrWhite,
                          color: AppConstants.clrDialogBtnYesBg,
                          icon: false)
                    ],
                  ),
                );
              }));
        });
  }

  warningDialog(BuildContext context) {
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
                  Image.asset(
                    AppConstants.warning_image,
                    width: 100,
                    height: 100,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(AppConstants.warning1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize16,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w600))),
                  const Text(AppConstants.warning2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppConstants.mediumFontSize16,
                          fontFamily: AppConstants.fontPoppinsRegular,
                          color: AppConstants.clrWhite,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            height: 50,
                            width: AppConstants.displayWidth(context) * 0.35,
                            onTap: () => Navigator.pop(context),
                            padding: const EdgeInsets.all(10),
                            radius: 12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize15,
                            text: AppConstants.no,
                            textColor: AppConstants.clrWhite,
                            color: AppConstants.clrDialogBtnNoBg,
                            icon: false),
                        CustomButton(
                            height: 50,
                            width: AppConstants.displayWidth(context) * 0.35,
                            onTap: () => Navigator.pop(context),
                            padding: const EdgeInsets.all(10),
                            radius: 12,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            fontSize: AppConstants.mediumFontSize15,
                            text: AppConstants.yes,
                            textColor: AppConstants.clrWhite,
                            color: AppConstants.clrDialogBtnYesBg,
                            icon: false)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  doneDialog1(BuildContext context) {
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
                  Image.asset(
                    AppConstants.done_image,
                    width: 100,
                    height: 100,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(AppConstants.doneString,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: AppConstants.mediumFontSize16,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              color: AppConstants.clrWhite,
                              fontWeight: FontWeight.w600))),
                ],
              ),
            ),
          );
        });
  }

  chooseOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppConstants.clrDialogBg,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text.rich(
                    TextSpan(
                        text: 'Your pocket have ',
                        style: TextStyle(
                            fontSize: AppConstants.mediumFontSize20,
                            fontFamily: AppConstants.fontPoppinsRegular,
                            color: AppConstants.clrWhite),
                        children: [
                          TextSpan(
                              text: '2 ',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize20,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  color: AppConstants.clrButtonGreen)),
                          TextSpan(
                              text: 'coins.\n',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize20,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  color: AppConstants.clrWhite)),
                          TextSpan(
                              text: 'Buy now:',
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize20,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  color: AppConstants.clrWhite))
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      makePayment(100);
                    //  _con!.purchaseCoinsApi(context, _con!.applicantDetailData.applicantId.toString(), 100).then((value) {
                     //   _con!.getApplicantDetailApi(widget.applicantId.toString(), false);
                    //  });
                    },
                    child: coinWidget('100','100'),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: (){
                      makePayment(600);
                      // _con!.purchaseCoinsApi(context, _con!.applicantDetailData.applicantId.toString(), 600).then((value) {
                      //   _con!.getApplicantDetailApi(widget.applicantId.toString(), false);
                      // });
                    },
                    child: coinWidget('600','500'),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: (){
                      makePayment(1000);
                      // _con!.purchaseCoinsApi(context, _con!.applicantDetailData.applicantId.toString(), 1000).then((value) {
                      //   _con!.getApplicantDetailApi(widget.applicantId.toString(), false);
                      // });
                    },
                    child: coinWidget('1000','800'),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: (){
                      makePayment(10000);
                      // _con!.purchaseCoinsApi(context, _con!.applicantDetailData.applicantId.toString(), 10000).then((value) {
                      //   _con!.getApplicantDetailApi(widget.applicantId.toString(), false);
                      // });
                    },
                    child: coinWidget('10000','5000'),
                  ),
                  const SizedBox(height: 20),
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
  Widget coinWidget(String coins,String rmb){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppConstants.clrDialogBtnNoBg,
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 15),
      child: Row(
        children: [
          Image.asset(AppConstants.goldImage,
              height: 25, width: 25),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                '$coins Coins',
                style: const TextStyle(
                    fontSize: AppConstants.mediumFontSize17,
                    color: AppConstants.clrWhite,
                    fontWeight: FontWeight.w700,
                    fontFamily:
                    AppConstants.fontPoppinsRegular),
              ),
              Text(
                '$rmb RMB',
                style: TextStyle(
                    fontSize: AppConstants.mediumFontSize14,
                    color: AppConstants.clrWhite,
                    fontWeight: FontWeight.w500,
                    fontFamily:
                    AppConstants.fontPoppinsRegular),
              )
            ],
          )
        ],
      ),
    );
  }
}
