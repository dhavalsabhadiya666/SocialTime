import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';

class MyPictureScreen extends StatefulWidget {
  @override
  _MyPictureScreenState createState() => _MyPictureScreenState();
}

class _MyPictureScreenState extends State<MyPictureScreen> {
  int isSelected =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        elevation: 0,
        title: const Text(
          AppConstants.myPicture,
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
        actions: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(AppConstants.delete,
                height: 22, width: 22, color: AppConstants.clrWhite),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {},
            child: Image.asset(AppConstants.select_list,
                height: 40, width: 40, color: AppConstants.clrWhite),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
            itemCount: 10,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isSelected = i;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.47,
                      width: MediaQuery.of(context).size.width * 0.47,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppConstants.clrBlack26,
                          image: const DecorationImage(
                              image: AssetImage(AppConstants.temp_image))),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child:   isSelected ==i?  Image.asset(AppConstants.checkCircle,height: 25,width: 25): Container(
                                margin: const EdgeInsets.only(top: 5, right: 10),
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppConstants.clrWhite, width: 2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:
                            Image.asset(AppConstants.play, width: 50, height: 50),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Image.asset(AppConstants.heart,
                                    width: 20, height: 20),
                                const SizedBox(width: 10),
                                const Text('15k',
                                    style: TextStyle(
                                        color: AppConstants.clrWhite,
                                        fontFamily: AppConstants.fontPoppinsRegular,
                                        fontSize: AppConstants.mediumFontSize14,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Text(
                    'Lorem Ipsum is simply dummy text of loram the...',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppConstants.clrWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: AppConstants.mediumFontSize14,
                        fontFamily: AppConstants.fontPoppinsRegular),
                  )
                ],
              );
            }),
      ),
    );
  }
}
