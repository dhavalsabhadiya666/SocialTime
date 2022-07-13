
import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';

class MessageBubble extends StatelessWidget {
   MessageBubble({ required this.text, required this.isMe , required this.dateTime});

  // final String sender;
  final String text;
  final String dateTime;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        (isMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   sender,
          //   style: const TextStyle(
          //     fontSize: 12.0,
          //     color: Colors.black54,
          //   ),
          // ),

          Row(
            mainAxisAlignment:(!isMe)?MainAxisAlignment.start :MainAxisAlignment.end ,
            children: [
              (!isMe)?   Container(
                height: 34,
                width: 34,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(AppConstants.userProfile),
                        fit: BoxFit.cover)),
              ):Container(),
              Container(
                decoration: BoxDecoration(
                  gradient: (!isMe)?const LinearGradient(colors: [AppConstants.clrBlack26,AppConstants.clrBlack26]):AppConstants().linearGradient,
                  borderRadius: (isMe)
                      ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))
                      : const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),

                ),

                // elevation: 5.0,
                // color: (isMe) ? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '$text',
                    style: const TextStyle(
                      color:  AppConstants.clrWhite,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              dateTime,
              style: const TextStyle(
                fontSize: 12.0,
                color: AppConstants.clrWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}