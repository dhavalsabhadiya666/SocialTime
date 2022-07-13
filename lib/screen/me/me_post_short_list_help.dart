import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/custom_widget/new_flutter_tindercard.dart'
    as tinderCard;
import 'package:pinmetar_app/utils/constants.dart';

class MeShortListHelpDetails extends StatefulWidget {
  const MeShortListHelpDetails({Key? key}) : super(key: key);

  @override
  _MeShortListHelpDetailsState createState() => _MeShortListHelpDetailsState();
}

class _MeShortListHelpDetailsState extends State<MeShortListHelpDetails> {
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerCenterRight;

  bool isConfetti = false;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    super.dispose();
    _controllerTopCenter.dispose();
    _controllerCenterRight.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }



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
        child: Stack(
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
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomButton(
                                    height: 40,
                                    width: AppConstants.displayWidth(context) * 0.35,
                                    onTap: () {},
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
                        const SizedBox(height: 8),
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
                             Container(),
                              GestureDetector(
                                onTap: () {
                                  Future.delayed(const Duration(milliseconds: 50),
                                      () {
                                        setState(() {
                                          isConfetti = true;
                                        });

                                        if (isConfetti == true) {
                                          _controllerTopCenter.play();
                                          _controllerCenterRight.play();
                                        }
                                    controller!.triggerUp();
                                  });
                                },
                                child:  Container(
                                  height: 60,
                                  width: 60,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: AppConstants.clrBlack,
                                      shape: BoxShape.circle),
                                  child: Image.asset(AppConstants.like1,
                                      height: 30, width: 30),
                                ),
                              ),
                              Container(),
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

                    });
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    setState(() {

                    });
                    //Card is RIGHT swiping
                  }else{
                    setState(() {

                    });
                  }
                },
                swipeCompleteCallback:
                    (tinderCard.CardSwipeOrientation orientation, int index) {
                  /// Get orientation & index of swiped card!
                      if(orientation == tinderCard.CardSwipeOrientation.down){
                        setState(() {

                        });

                      }else if(orientation == tinderCard.CardSwipeOrientation.left){
                        setState(() {

                        });
                      }else if(orientation == tinderCard.CardSwipeOrientation.right){
                        setState(() {

                        });

                      }else if(orientation == tinderCard.CardSwipeOrientation.recover){
                        setState(() {

                        });
                      }else if(orientation == tinderCard.CardSwipeOrientation.up){
                        setState(() {

                        });
                      }else{

                      }
                },
              ),
            ),
            isConfetti == true ? Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirection: 0, // radial value - RIGHT
                emissionFrequency: 0.6,
                minimumSize: const Size(10,
                    10), // set the minimum potential size for the confetti (width, height)
                maximumSize: const Size(50,
                    50), // set the maximum potential size for the confetti (width, height)
                numberOfParticles: 1,
                gravity: 0.1,
              ),
            ) : Container(),
            isConfetti == true ? Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _controllerCenterRight,
                blastDirection: pi, // radial value - LEFT
                particleDrag: 0.05, // apply drag to the confetti
                emissionFrequency: 0.05, // how often it should emit
                numberOfParticles: 20, // number of particles to emit
                gravity: 0.05, // gravity - or fall speed
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink
                ], // manually specify the colors to be used
              ),
            ) : Container(),
          ],
        ),
      ),

    );
  }
}
