import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/search_widget.dart';
import 'package:pinmetar_app/screen/message/chat_room_page.dart';
import 'package:pinmetar_app/utils/constants.dart';

class CreateChatRoom extends StatefulWidget {
  const CreateChatRoom({Key? key}) : super(key: key);

  @override
  _CreateChatRoomState createState() => _CreateChatRoomState();
}

class _CreateChatRoomState extends State<CreateChatRoom>
    with TickerProviderStateMixin {
  TextEditingController controllerSearchMyFan = TextEditingController();
  TextEditingController controllerSearch = TextEditingController();
  TabController? tabController;

  int tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        appBar: AppBar(
          backgroundColor: AppConstants.clrBlack,
          leadingWidth: 40,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            AppConstants.createChatRoom,
            style: TextStyle(
                color: AppConstants.clrWhite,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          actions: [
             IconButton(onPressed: () {}, icon: const Icon(Icons.done))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 0.80,
              color: AppConstants.clrLightGreyTxt,
            ),
            TabBar(
              controller: tabController,
              //indicator: BoxDecoration(color: kOrangeColor),

              unselectedLabelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppConstants.fontPoppinsRegular),
              indicatorColor: AppConstants.clrGreen08,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                  fontSize: 20,
                  color: AppConstants.clrGreen08,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstants.fontPoppinsBold),
              labelColor: AppConstants.clrGreen08,
              unselectedLabelColor: AppConstants.clrLightGreyTxt,
              onTap: (val) {
                setState(() {
                  tabIndex = val;
                });
              },
              tabs: const <Widget>[
                Tab(child: Text(AppConstants.myFans)),
                Tab(child: Text(AppConstants.privateChat)),
              ],
            ),
            Container(
              height: 0.80,
              color: AppConstants.clrLightGreyTxt,
            ),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [myFans(), privateChat()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget myFans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatRoomScreen()));
                },
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                          child: Image.asset(AppConstants.userProfile,
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 30,
                          width: 30,
                          child: Image.asset(AppConstants.editSquare),
                          decoration: const BoxDecoration(
                              color: AppConstants.clrBlack26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ))
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: searchWidget(
                  hint: AppConstants.enterChatRoomTitle,
                  controller: controllerSearchMyFan,
                  fillColor: AppConstants.clrBlack26,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatRoomScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            AppConstants.attendees.toUpperCase(),
            style: const TextStyle(
                color: AppConstants.clrWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomScreen(),));
                },
                child: Container(
                  color: AppConstants.clrBlack26,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(AppConstants.chatProfile),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Baranan',
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppConstants.clrDivider1,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget privateChat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(
            children: [
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                        child: Image.asset(
                            AppConstants.userProfile,
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        child: Image.asset(AppConstants.editSquare),
                        decoration: const BoxDecoration(
                            color: AppConstants.clrBlack26,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                      ))
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: searchWidget(
                  hint: AppConstants.enterChatRoomTitle,
                  controller: controllerSearchMyFan,
                  fillColor: AppConstants.clrBlack26,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatRoomScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            AppConstants.attendees.toUpperCase(),
            style: const TextStyle(
                color: AppConstants.clrWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                color: AppConstants.clrBlack26,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(AppConstants.chatProfile),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Baranan',
                            style: TextStyle(
                                color: AppConstants.clrWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppConstants.clrDivider1,
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
