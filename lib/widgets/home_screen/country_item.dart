import 'package:flutter/material.dart';
import 'package:oxoo/models/home_content.dart';
import 'package:oxoo/screen/all_country_screen.dart';
import 'package:oxoo/screen/content_country_based_screen.dart';
import 'package:oxoo/strings.dart';
import 'package:oxoo/style/theme.dart';

import '../home_screen_more_widget.dart';

// ignore: must_be_immutable
class HomeScreenCountryList extends StatelessWidget {
  List<AllCountry>? countryList;
  bool isDark = false;
  HomeScreenCountryList({Key? key, required this.countryList, required this.isDark}) : super(key: key);

  final List<LinearGradient> gradientBG = [
    CustomTheme.gradient1,
    CustomTheme.gradient2,
    CustomTheme.gradient3,
    CustomTheme.gradient4,
    CustomTheme.gradient5,
    CustomTheme.gradient6,
  ];

  int index = 0;
  LinearGradient getRandomColor() {
    if (index >= 5) {
      index = 0;
    }
    index++;
    return gradientBG[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2),
      height: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 6.0, top: 4.0, right: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppContent.exploreByCountry,
                  style: isDark ? CustomTheme.bodyText2White : CustomTheme.coloredBodyText2,
                ),
                HomeScreenMoreWidget(
                  routeName: AllCountryScreen.route,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: countryList!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContentCountryBasedScreen(
                                countryID: countryList![index].countryId!,
                                countryName: countryList![index].name,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        gradient: getRandomColor(),
                      ),
                      margin: EdgeInsets.only(right: 2),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.network(
                                countryList![index].imageUrl!,
                                width: 35,
                                height: 35,
                              ),
                            ),
                            Container(
                              child: Text(
                                countryList![index].name!,
                                style: CustomTheme.bodyText3White,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
