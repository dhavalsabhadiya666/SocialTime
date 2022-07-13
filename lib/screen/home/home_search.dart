import 'package:flutter/material.dart';
import 'package:pinmetar_app/custom_widget/search_widget.dart';
import 'package:pinmetar_app/utils/constants.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({Key? key}) : super(key: key);

  @override
  _HomeSearchScreenState createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  List<String> hotSearch = [
    'Helping Business',
    'Tutor',
    'Babysitter',
    'Tutor',
    'Management',
    'Technologies',
    'Idea',
    'Helping Business'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.clrBlack,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          children: [
            searchWidget(
                hint: 'Search...',
                fillColor: AppConstants.clrBlack26,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    AppConstants.search_icon,
                    height: 10,
                    width: 10,
                    color: AppConstants.clrLightGreyTxt,
                  ),
                )),
            ListView.builder(
                padding: EdgeInsets.only(top: 20),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.history,
                              color: AppConstants.clrLightGreyTxt,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Helping Business',
                              style: TextStyle(
                                  color: AppConstants.clrWhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.north_west_outlined,
                          color: AppConstants.clrLightGreyTxt,
                        ),
                      ],
                    ),
                  );
                }),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 15),
              child: Text(
                AppConstants.hotSearchKeyword,
                style: TextStyle(
                    color: AppConstants.clrWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Wrap(
              children: hotSearch
                  .map((e) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppConstants.clrBlack26),
                        child: Text(
                          e,
                          style: const TextStyle(
                              color: AppConstants.clrWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
