import 'package:flutter/material.dart';
import 'package:flutter_pay/flutter_pay.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/controllers/pocket_history_controller.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/dialog.dart';
import 'package:pinmetar_app/utils/constants.dart';

class PocketScreen extends StatefulWidget {
  String applicantId;
  PocketScreen(this.applicantId);
  @override
  _PocketScreenState createState() => _PocketScreenState();
}

class _PocketScreenState extends StateMVC<PocketScreen> {
  PocketHistoryController? _con;

  _PocketScreenState() : super(PocketHistoryController()) {
    _con = controller as PocketHistoryController;
  }

  String? dropDownValue = 'Last 7 Day';
  List<String> dropDownList = ['Last 7 Day', 'Last 30 Day'];

  FlutterPay flutterPay = FlutterPay();
  String result = "Result will be shown here";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con!.getPocketHistoryApi(1, true);
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
        _con!.purchaseCoinsApi(context, widget.applicantId.toString(), coins).then((value) {
          _con!.getPocketHistoryApi(1, true);
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
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.clrWhite,
            size: 25,
          ),
        ),
        title: const Text(
          AppConstants.pocket,
          style: TextStyle(
              fontSize: AppConstants.mediumFontSize20,
              fontFamily: AppConstants.fontPoppinsRegular,
              color: AppConstants.clrWhite,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppConstants.clrBlack26),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(AppConstants.goldImage,
                          width: 70, height: 70),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppConstants.availableCoins,
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15),
                          ),
                          Text(
                            '${_con!.pocketHistoryDataModel!.balance.toString()} Coins',
                            style: const TextStyle(
                                color: AppConstants.clrWhite,
                                fontFamily: AppConstants.fontPoppinsRegular,
                                fontSize: AppConstants.mediumFontSize15),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          coinBuyDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            gradient: AppConstants().linearGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                                color: AppConstants.clrBlack26,
                                // border: Border.all(
                                //     color: AppConstants.clrDarkGreyText),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(AppConstants.buyNow,
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize13,
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    color: AppConstants.clrWhite)),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          gradient: AppConstants().linearGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppConstants.clrBlack26,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(AppConstants.inviteFriends,
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize13,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  color: AppConstants.clrWhite)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          gradient: AppConstants().linearGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: AppConstants.clrBlack26,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(AppConstants.donateString,
                              style: TextStyle(
                                  fontSize: AppConstants.mediumFontSize13,
                                  fontFamily: AppConstants.fontPoppinsRegular,
                                  color: AppConstants.clrWhite)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppConstants.coinsHistory,
                    style: TextStyle(
                        color: AppConstants.clrWhite,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        fontSize: AppConstants.mediumFontSize15,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppConstants.clrDarkGreyText)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isDense: true,
                        dropdownColor: AppConstants.clrBlack26,
                        value: dropDownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropDownValue = newValue! as String?;
                          });
                        },
                        items: dropDownList.map((str) {
                          return DropdownMenuItem(
                            value: str,
                            child: Text(str.toString(),
                                style: const TextStyle(
                                    fontSize: AppConstants.mediumFontSize14,
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    color: AppConstants.clrWhite)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 12, vertical: 4),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border:
                  //             Border.all(color: AppConstants.clrDarkGreyText)),
                  //     child: Row(
                  //       children: const [
                  //         Text(
                  //           'Last 7 Days',
                  //           style: TextStyle(
                  //               fontSize: AppConstants.mediumFontSize15,
                  //               fontFamily: AppConstants.fontPoppinsRegular,
                  //               color: AppConstants.clrWhite),
                  //         ),
                  //         Icon(
                  //           Icons.arrow_drop_down_rounded,
                  //           size: 20,
                  //           color: AppConstants.clrWhite,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Expanded(
                child: _con!.pocketHistoryDataModel!.wallet == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            _con!.pocketHistoryDataModel!.wallet!.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          return GestureDetector(
                            onTap: () {
                              //coinBuyDialog(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppConstants.clrBlack26),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _con!.pocketHistoryDataModel!.wallet!
                                              .data![i].comment
                                              .toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: AppConstants.clrWhite,
                                              fontFamily:
                                                  AppConstants.fontPoppinsBold,
                                              fontSize:
                                                  AppConstants.mediumFontSize15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // const Text.rich(TextSpan(
                                        //     text: '${AppConstants.donatedBy}: ',
                                        //     style: TextStyle(
                                        //         color: AppConstants.clrWhite,
                                        //         fontFamily:
                                        //             AppConstants.fontPoppinsRegular,
                                        //         fontSize:
                                        //             AppConstants.mediumFontSize13,
                                        //         fontWeight: FontWeight.w500),
                                        //     children: [
                                        //       TextSpan(
                                        //           text: 'John Deo',
                                        //           style: TextStyle(
                                        //               color: AppConstants.clrWhite,
                                        //               fontFamily: AppConstants
                                        //                   .fontPoppinsRegular,
                                        //               fontSize: AppConstants
                                        //                   .mediumFontSize13))
                                        //     ])),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                AppConstants.calendarImage,
                                                height: 20,
                                                width: 20),
                                            const SizedBox(width: 10),
                                            Text(
                                              DateFormat('yyyy/MM/dd')
                                                  .format(_con!
                                                      .pocketHistoryDataModel!
                                                      .wallet!
                                                      .data![i]
                                                      .createdAt!)
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: AppConstants
                                                      .clrDarkGreyText,
                                                  fontSize: AppConstants
                                                      .mediumFontSize12,
                                                  fontFamily: AppConstants
                                                      .fontPoppinsRegular),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _con!.pocketHistoryDataModel!.wallet!.data![i].transactionType ==1?
                                      Text(
                                        '+ ${_con!.pocketHistoryDataModel!.wallet!.data![i].coins.toString()} Coins',
                                        style: const TextStyle(
                                            fontFamily:
                                                AppConstants.fontPoppinsRegular,
                                            fontSize:
                                                AppConstants.mediumFontSize13,
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.clrButtonGreen),
                                      ): Text(
                                        '- ${_con!.pocketHistoryDataModel!.wallet!.data![i].coins.toString()} Coins',
                                        style: const TextStyle(
                                            fontFamily:
                                            AppConstants.fontPoppinsRegular,
                                            fontSize:
                                            AppConstants.mediumFontSize13,
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.clrRed),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(AppConstants.goldImage,
                                          width: 25, height: 25),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }
  coinBuyDialog(BuildContext context) {
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
                  const Text(AppConstants.howManyCoinsDoYouWantToBuy,
                    style: TextStyle(
                        fontSize: AppConstants.mediumFontSize20,
                        fontFamily: AppConstants.fontPoppinsRegular,
                        color: AppConstants.clrWhite),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      makePayment(100);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.clrDialogBtnNoBg,
                      ),
                      padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset(AppConstants.goldImage,
                              height: 25, width: 25),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '100 Coins',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize17,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              ),
                              Text(
                                '100 RMB',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize14,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: (){
                      makePayment(600);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.clrDialogBtnNoBg,
                      ),
                      padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset(AppConstants.goldImage,
                              height: 25, width: 25),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '600 Coins',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize17,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              ),
                              Text(
                                '500 RMB',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize14,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: (){
                      makePayment(1000);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.clrDialogBtnNoBg,
                      ),
                      padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset(AppConstants.goldImage,
                              height: 25, width: 25),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '1000 Coins',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize17,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              ),
                              Text(
                                '800 RMB',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize14,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: (){
                      makePayment(10000);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.clrDialogBtnNoBg,
                      ),
                      padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset(AppConstants.goldImage,
                              height: 25, width: 25),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '10000 Coins',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize17,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              ),
                              Text(
                                '5000 RMB',
                                style: TextStyle(
                                    fontSize: AppConstants.mediumFontSize14,
                                    color: AppConstants.clrWhite,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConstants.fontPoppinsRegular),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
}
