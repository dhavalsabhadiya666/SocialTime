import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/search_widget.dart';
import 'package:pinmetar_app/utils/constants.dart';

class PrivateChatScreen extends StatefulWidget {
  const PrivateChatScreen({Key? key}) : super(key: key);

  @override
  _PrivateChatScreenState createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> with TickerProviderStateMixin {
  TextEditingController controllerSearchMyFan = TextEditingController();
  TextEditingController controllerSearch = TextEditingController();
  List<int> selectIndex = [];
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
            AppConstants.messages,
            style: TextStyle(
                color: AppConstants.clrWhite,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            tabIndex == 1
                ? Container()
                : IconButton(onPressed: () {}, icon: const Icon(Icons.done))
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
              onTap: (val){
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
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: searchWidget(
              hint: 'Search...',
              controller: controllerSearchMyFan,
              fillColor: AppConstants.clrBlack26,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controllerSearchMyFan.clear();
                      });
                    },
                    child: const Icon(Icons.cancel,
                        color: AppConstants.clrLightGreyTxt)),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  AppConstants.search_icon,
                  height: 10,
                  width: 10,
                  color: AppConstants.clrLightGreyTxt,
                ),
              )),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('B',
                        style: TextStyle(
                            color: AppConstants.clrWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        color: AppConstants.clrBlack26,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (selectIndex.contains(index)) {
                                          setState(() {
                                            selectIndex.remove(index);
                                          });
                                        } else {
                                          setState(() {
                                            selectIndex.add(index);
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        selectIndex.contains(index)
                                            ? AppConstants.checkCircle
                                            : AppConstants.unselectCircle,
                                        height: 25,
                                        width: 25,
                                      )),
                                  const SizedBox(width: 15),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AppConstants.chatProfile),
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
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Widget privateChat() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: searchWidget(
              hint: 'Search...',
              controller: controllerSearch,
              fillColor: AppConstants.clrBlack26,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controllerSearch.clear();
                      });
                    },
                    child: const Icon(Icons.cancel,
                        color: AppConstants.clrLightGreyTxt)),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  AppConstants.search_icon,
                  height: 10,
                  width: 10,
                  color: AppConstants.clrLightGreyTxt,
                ),
              )),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                color: AppConstants.clrBlack26,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(AppConstants.userProfile),
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
