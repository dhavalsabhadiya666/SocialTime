import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/button.dart';
import 'package:pinmetar_app/screen/message/private_chat.dart';
import 'package:pinmetar_app/utils/constants.dart';

import 'chat_page.dart';
import 'create_chat_room.dart';

class MessageHomeScreen extends StatefulWidget {
  const MessageHomeScreen({Key? key}) : super(key: key);

  @override
  _MessageHomeScreenState createState() => _MessageHomeScreenState();
}

class _MessageHomeScreenState extends State<MessageHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        leadingWidth: 0,
        leading: Container(
          padding: EdgeInsets.zero,
        ),
        title: const Text(
          AppConstants.messages,
          style: TextStyle(
              color: AppConstants.clrWhite,
              fontSize: AppConstants.mediumFontSize20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CustomButton(
            margin: const EdgeInsets.all(15),
            height: 50,
            width: AppConstants.displayWidth(context),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateChatRoom()));
            },
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppConstants.clrBtnBlueGradient1,
                AppConstants.clrBtnBlueGradient2
              ],
            ),
            //     : const LinearGradient(colors: [
            //   AppConstants.clrTransparent,
            //   AppConstants.clrTransparent,
            // ]),
            textColor: AppConstants.clrWhite,
            radius: 15,
            icon: true,
            image: const Icon(
              Icons.add_circle,
              color: AppConstants.clrWhite,
            ),
            text: AppConstants.createChatRoom,
            fontSize: AppConstants.mediumFontSize18,
            fontFamily: AppConstants.fontPoppinsRegular,
            fontWeight: FontWeight.w500,
            border: Border.all(color: AppConstants.clrGreyText, width: 0.2),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => _buildChatItem(index),
              shrinkWrap: true,
              itemCount: 4,

            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatItem(int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context) => const ChatScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppConstants.userProfile),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                        border:
                            Border.all(color: AppConstants.clrWhite, width: 1)),
                  ),
                  top: 0,
                  left: 6,
                ),
              ],
            ),
            // const SizedBox(width: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Rose ward',
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontWeight: FontWeight.w600,
                                fontSize: AppConstants.mediumFontSize18)),
                        // Spacer(),
                        Text('24 min',
                            style: TextStyle(
                                color: AppConstants.clrGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: AppConstants.mediumFontSize11)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('Sound good to me!',
                            style: TextStyle(
                                color: AppConstants.clrDarkGreyText,
                                fontWeight: FontWeight.w400,
                                fontSize: AppConstants.mediumFontSize14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
