import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/new_flutter_tindercard.dart'
    as tinderCard;
import 'package:pinmetar_app/screen/me/me_post_short_list_help.dart';
import 'package:pinmetar_app/utils/constants.dart';

class MeHelpDetails extends StatefulWidget {
  const MeHelpDetails({Key? key}) : super(key: key);

  @override
  _MeHelpDetailsState createState() => _MeHelpDetailsState();
}

class _MeHelpDetailsState extends State<MeHelpDetails> {
  @override
  void initState() {
    super.initState();
  }

  int isLable = 0;

  @override
  Widget build(BuildContext context) {
    tinderCard.CardController? controller; //Use this to trigger swap.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          AppConstants.postHelpTitle,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 1.60,
              child: tinderCard.TinderSwapCard(
                swipeUp: true,
                swipeDown: true,
                orientation: tinderCard.AmassOrientation.bottom,
                totalNum: 10,
                stackNum: 3,
                swipeEdge: 3.0,
                maxWidth: screenWidth * 0.9,
                maxHeight: screenWidth * 1.40,
                minWidth: screenWidth * 0.7,
                minHeight: screenWidth * 1.35,
                cardBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: AppConstants.clrBlack26,
                        borderRadius: BorderRadius.circular(10)),
                    width: 150,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.70,
                          child: Stack(
                            children: [
                              Container(
                              //  width: MediaQuery.of(context).size.width,
                              //  height: MediaQuery.of(context).size.width * 0.60,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: const DecorationImage(
                                      image: AssetImage(AppConstants.userJobProfile),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            isLable==1?  Align(
                              alignment: Alignment.topLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 25,left: 30),
                                  height: MediaQuery.of(context).size.width * 0.10,
                                  width: MediaQuery.of(context).size.width * 0.38,
                                  decoration: BoxDecoration(
                                    color:AppConstants.clrRed08.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:  Center(
                                    child: Text(
                                      AppConstants.reject.toUpperCase(),
                                      style: const TextStyle(
                                          color: AppConstants.clrWhite, fontSize: 15,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                                : isLable==2?   Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 30,right: 30),
                                height: MediaQuery.of(context).size.width * 0.10,
                                width: MediaQuery.of(context).size.width * 0.38,
                                decoration: BoxDecoration(
                                  color:AppConstants.clrBlue08.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:  Center(
                                  child: Text(
                                    AppConstants.shortlist.toUpperCase(),
                                    style: const TextStyle(
                                        color: AppConstants.clrWhite, fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ):
                            Container(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomButton(
                                    height: 40,
                                    width: AppConstants.displayWidth(context) * 0.35,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MeShortListHelpDetails(),));


                                    },
                                    radius: 40,
                                    fontFamily: AppConstants.fontPoppinsRegular,
                                    fontSize: AppConstants.mediumFontSize13,
                                    text: AppConstants.connect,
                                    textColor: AppConstants.clrWhite,
                                    color: AppConstants.clrDialogBtnYesBg,
                                    fontWeight: FontWeight.normal,
                                    icon: false),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'John Deo',
                          style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize17,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Product Designer',
                          style: TextStyle(
                              color: AppConstants.clrDarkGreyText,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize12),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppConstants.clrBtnBlueText,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('M.C.A', style: TextStyle(
                              color: AppConstants.clrWhite,
                              fontFamily: AppConstants.fontPoppinsRegular,
                              fontSize: AppConstants.mediumFontSize12,
                              fontWeight: FontWeight.w500),),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Future.delayed(const Duration(milliseconds: 50),
                                      () {
                                    controller!.triggerLeft();
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: AppConstants.clrBlack,
                                      shape: BoxShape.circle),
                                  child: Image.asset(AppConstants.undoL,
                                      height: 30, width: 30),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Future.delayed(const Duration(milliseconds: 50),
                                      () {
                                    controller!.triggerUp();
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: AppConstants.clrBlack,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.favorite,color: AppConstants.clrRed,size: 30),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Future.delayed(const Duration(milliseconds: 50),
                                      () {
                                    controller!.triggerRight();
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: AppConstants.clrBlack,
                                      shape: BoxShape.circle),
                                  child: Image.asset(AppConstants.undoR,
                                      height: 30, width: 30),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                cardController: controller = tinderCard.CardController(),
                swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    setState(() {
                      isLable = 1;
                    });
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    setState(() {
                      isLable = 2;
                    });
                    //Card is RIGHT swiping
                  }else{
                    setState(() {
                      isLable = 0;
                    });
                  }
                },
                swipeCompleteCallback:
                    (tinderCard.CardSwipeOrientation orientation, int index) {
                  /// Get orientation & index of swiped card!
                      if(orientation == tinderCard.CardSwipeOrientation.down){
                        setState(() {
                          isLable = 0;
                        });

                      }else if(orientation == tinderCard.CardSwipeOrientation.left){
                        setState(() {
                          isLable = 0;
                        });
                      }else if(orientation == tinderCard.CardSwipeOrientation.right){
                        setState(() {
                          isLable = 0;
                        });

                      }else if(orientation == tinderCard.CardSwipeOrientation.recover){
                        setState(() {
                          isLable = 0;
                        });
                      }else if(orientation == tinderCard.CardSwipeOrientation.up){
                        setState(() {
                          isLable = 0;
                        });
                      }else{

                      }
                },
              ),
            ),
          ],
        ),
      ),

      // Container(
      //   margin: const EdgeInsets.only(bottom: 50),
      //   child: TinderSwapCard(
      //     stackNum: 3,
      //     totalNum: 10,
      //     swipeUp: true,
      //     swipeDown: true,
      //     maxHeight: screenHeight * 0.90,
      //     maxWidth: screenWidth * 0.95,
      //     minWidth: screenWidth * 0.8,
      //     minHeight: screenHeight * 0.80,
      //     cardController: controller = CardController(),
      //     //cardController: controller,
      //     cardBuilder: (context, index) {
      //       return Container(
      //             decoration: BoxDecoration(
      //                 color: AppConstants.clrBlack26,
      //                 borderRadius: BorderRadius.circular(10)),
      //         width: 150,
      //       child: Column(
      //         children: [
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             height: MediaQuery.of(context).size.width * 0.48,
      //             margin: const EdgeInsets.symmetric(
      //                 vertical: 15, horizontal: 15),
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 image: const DecorationImage(
      //                   image: AssetImage(AppConstants.previewImage),
      //                   fit: BoxFit.cover,
      //                 )),
      //           ),
      //
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               CustomButton(
      //                   height: 40,
      //                   width: AppConstants.displayWidth(context) * 0.35,
      //                   onTap: () {
      //                   },
      //                   radius: 40,
      //                   fontFamily: AppConstants.fontPoppinsRegular,
      //                   fontSize: AppConstants.mediumFontSize13,
      //                   text: AppConstants.applyLater,
      //                   textColor: AppConstants.clrWhite,
      //                   color: AppConstants.clrDialogBtnNoBg,
      //                   fontWeight: FontWeight.normal,
      //                   icon: false),
      //               SizedBox(width: 10),
      //               CustomButton(
      //                   height: 40,
      //                   width: AppConstants.displayWidth(context) * 0.35,
      //                   onTap: () {
      //                   },
      //                   radius: 40,
      //                   fontFamily: AppConstants.fontPoppinsRegular,
      //                   fontSize: AppConstants.mediumFontSize13,
      //                   text: AppConstants.applyNow,
      //                   textColor: AppConstants.clrWhite,
      //                   color: AppConstants.clrDialogBtnYesBg,
      //                   fontWeight: FontWeight.normal,
      //                   icon: false),
      //             ],
      //           ),
      //           const SizedBox(height: 20),
      //           const Text(
      //             AppConstants.mathematicsTutor,
      //             style: TextStyle(
      //                 color: AppConstants.clrWhite,
      //                 fontFamily: AppConstants.fontPoppinsRegular,
      //                 fontSize: AppConstants.mediumFontSize17,
      //                 fontWeight: FontWeight.w600),
      //           ),
      //           const SizedBox(height: 15),
      //           const Text(
      //             'Every Tue, 7 PM',
      //             style: TextStyle(
      //                 color: AppConstants.clrDarkGreyText,
      //                 fontFamily: AppConstants.fontPoppinsRegular,
      //                 fontSize: AppConstants.mediumFontSize12),
      //           ),
      //           const SizedBox(height: 15),
      //           const Text(
      //             AppConstants.tempAddress,
      //             style: TextStyle(
      //                 color: AppConstants.clrWhite,
      //                 fontFamily: AppConstants.fontPoppinsRegular,
      //                 fontSize: AppConstants.mediumFontSize13),
      //           ),
      //           const Text(
      //             AppConstants.tempAddress,
      //             style: TextStyle(
      //                 color: AppConstants.clrWhite,
      //                 fontFamily: AppConstants.fontPoppinsRegular,
      //                 fontSize: AppConstants.mediumFontSize13),
      //           ),
      //           const Padding(
      //             padding: EdgeInsets.only(left: 15, right: 15,top: 15,bottom: 8),
      //             child: Text(
      //               AppConstants.iWantToFindATutor,
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                   color: AppConstants.clrWhite,
      //                   fontFamily: AppConstants.fontPoppinsRegular,
      //                   fontSize: AppConstants.mediumFontSize13,
      //                   fontWeight: FontWeight.w500),
      //             ),
      //           ),
      //           Container(
      //             height: 30,
      //             width: 30,
      //             decoration: const BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 image: DecorationImage(
      //                     image: AssetImage(AppConstants.userProfile),
      //                     fit: BoxFit.cover)),
      //           ),
      //           const Text(
      //             'John Deo',
      //             style: TextStyle(
      //                 color: AppConstants.clrWhite,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.w500),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 GestureDetector(
      //                   onTap: (){
      //                     controller.triggerLeft();
      //                     Future.delayed(const Duration(milliseconds: 50), () {
      //
      //                     });
      //                   },
      //                   child: Container(
      //                     height: 50,
      //                     width: 50,
      //                     padding: const EdgeInsets.all(8),
      //                     decoration: const BoxDecoration(color: AppConstants.clrBlack,shape: BoxShape.circle),
      //                     child: Image.asset(AppConstants.undoL,height: 30,width: 30),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 60,
      //                   width: 60,
      //                   padding: const EdgeInsets.all(10),
      //                   decoration: const BoxDecoration(color: AppConstants.clrBlack,shape: BoxShape.circle),
      //                   child: Image.asset(AppConstants.like1,height: 30,width: 30),
      //                 ),
      //                 Container(
      //                   height: 50,
      //                   width: 50,
      //                   padding: const EdgeInsets.all(8),
      //                   decoration: const BoxDecoration(color: AppConstants.clrBlack,shape: BoxShape.circle),
      //                   child: Image.asset(AppConstants.undoR,height: 30,width: 30),
      //                 )
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //       );
      //     },
      //     swipeUpdateCallback: (details, align) async {
      //       print('swipeUpdateCallback   ${align.toString()}');
      //       print('swipeUpdateCallback details  ${details.toString()}');
      //
      //       if (align.x < 0) {
      //         //Card is LEFT swiping
      //       } else if (align.x > 0) {
      //         //Card is RIGHT swiping
      //       }
      //       // var matchCardItemProvider =
      //       // context.read<MatchCardItemProvider>();
      //       // print("index is $index");
      //       // print("delta is ${align.x}");
      //       // if (align.x < 0) {
      //       //   setNopeOpacity(
      //       //       normalizeOpacityValue(-align.x));
      //       //   if (align.x < -3) {
      //       //     setIsClosed(true);
      //       //   } else {
      //       //     setIsClosed(false);
      //       //   }
      //       // } else if (align.x > 0) {
      //       //   // print("align x is: ${align.x}");
      //       //   setLikeOpacity(
      //       //       normalizeOpacityValue(align.x));
      //       //   if (align.x > 3) {
      //       //     setIsLiked(true);
      //       //   } else {
      //       //     setIsLiked(false);
      //       //   }
      //       // }
      //     },
      //     swipeCompleteCallback:
      //         (orientation, index) async {
      //           print('swipeCompleteCallback   ${orientation.toString()}');
      //           print('swipeCompleteCallback details  ${index.toString()}');
      //       //   var matchCardItemProvider =
      //       //  context.read<MatchCardItemProvider>();
      //       // print("swipe complete index: $index");
      //       // var currentIndex = orientation !=
      //       //     CardSwipeOrientation.recover &&
      //       //     orientation !=
      //       //         CardSwipeOrientation.recovering
      //       //     ? index + 1
      //       //     : index;
      //       // // var item = matchingListProvider
      //       // //     .matchListResp?.data
      //       // //     ?.elementAt(index);
      //       //
      //       // setCard(currentIndex);
      //       // if (orientation == CardSwipeOrientation.up) {
      //       //   print("swiping up completed");
      //       // }
      //       // if (orientation == CardSwipeOrientation.down) {
      //       //   print("swiping down completed");
      //       // }
      //       // if (orientation == CardSwipeOrientation.left) {
      //       //   print("swiping left completed");
      //       //
      //       // }
      //       // if (orientation == CardSwipeOrientation.right) {
      //       //   print("swiping right completed");
      //       //
      //
      //     },
      //   ),
      // ),
    );
  }
}
