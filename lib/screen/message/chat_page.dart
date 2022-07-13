import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/message_bubble.dart';
import 'package:pinmetar_app/model/chat_bubble_model.dart';
import 'package:pinmetar_app/screen/message/private_chat.dart';
import 'package:pinmetar_app/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatBubbleModel> chatList = <ChatBubbleModel>[];

  TextEditingController sendMessageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatList.add(ChatBubbleModel(
        image: AppConstants.userProfile,
        dateTime: '1:30 PM',
        isMe: true,
        text: 'Hii'));
    chatList.add(ChatBubbleModel(
        image: AppConstants.userProfile,
        dateTime: '2:30 PM',
        isMe: false,
        text: 'Hii'));
    chatList.add(ChatBubbleModel(
        image: AppConstants.userProfile,
        dateTime: '2:40 PM',
        isMe: true,
        text: 'How are you?'));
    chatList.add(ChatBubbleModel(
        image: AppConstants.userProfile,
        dateTime: '3:00 PM',
        isMe: true,
        text: 'Fine, and you?'));
    chatList.add(ChatBubbleModel(
        image: AppConstants.userProfile,
        dateTime: '5:00 PM',
        isMe: true,
        text: 'Good'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.clrBlack,
      appBar: AppBar(
        backgroundColor: AppConstants.clrBlack,
        leadingWidth: 30,
        // leading: Container(
        //   padding: EdgeInsets.zero,
        // ),
        title: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivateChatScreen()));
          },
          child: Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(AppConstants.userProfile),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Rose ward',
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.mediumFontSize15,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Active 2 Hours ago',
                      style: TextStyle(
                          color: AppConstants.clrWhite,
                          fontSize: AppConstants.mediumFontSize13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: AppConstants.clrBlack26,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => MessageBubble(
                text: chatList[index].text.toString(),
                isMe: chatList[index].isMe as bool,
                dateTime: chatList[index].dateTime.toString()),
            shrinkWrap: true,
            itemCount: chatList.length,
          )),
          buildInputSection(),
        ],
      ),
    );
  }

  Widget buildInputSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      color: AppConstants.clrTransparent,
      child: Row(
        children: <Widget>[
          Expanded(child: inputBar()),
          const SizedBox(
            width: 5.0,
          ),
          sendMessageController.text.length != 0
              ? Image.asset(
                  AppConstants.sendMessage,
                  height: 46,
                  width: 46,
                )
              : Image.asset(
                  AppConstants.mic,
                  height: 46,
                  width: 46,
                ),
          // const CircleAvatar(
          //   child: Icon( Icons.mic),
          // ),
        ],
      ),
    );
  }

  Widget inputBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28.0),
      child: Container(
        color: AppConstants.clrBlack26,
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.insert_emoticon,
              size: 30.0,
              color: AppConstants.clrWhite,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: TextField(
                  controller: sendMessageController,
                  style: TextStyle(color: AppConstants.clrWhite),
                  decoration: InputDecoration(
                    fillColor: AppConstants.clrBlack26,
                    hintText: AppConstants.message,
                    hintStyle: TextStyle(color: AppConstants.clrDarkGreyText),
                    border: InputBorder.none,
                  ),
                  // controller: _textController,
                  // onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    // if (text.isNotEmpty) {
                    setState(() {});
                    // }
                  }
                  //
                  //   _handleChange(text);
                  // },
                  ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                    //isScrollControlled: true,
                  backgroundColor: AppConstants.clrBlack26 ,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0)),
                          color: AppConstants.clrBlack26,
                        ),

                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 30),

                        child: Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppConstants.fileRound,
                                  height: 52,
                                  width: 52,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(AppConstants.file,
                                      style: TextStyle(
                                          color: AppConstants.clrWhite,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                              AppConstants.fontPoppinsRegular,
                                          fontSize:
                                              AppConstants.mediumFontSize16)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    AppConstants.imageRound,
                                    height: 52,
                                    width: 52,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(AppConstants.images,
                                        style: TextStyle(
                                            color: AppConstants.clrWhite,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            AppConstants.fontPoppinsRegular,
                                            fontSize:
                                            AppConstants.mediumFontSize16)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Image.asset(
                AppConstants.sendFile,
                height: 22,
                width: 22,
              ),
            ),

            // Icon(
            //   Icons.attach_file,
            //   size: 30.0,
            //   color: AppConstants.clrWhite,
            // ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
