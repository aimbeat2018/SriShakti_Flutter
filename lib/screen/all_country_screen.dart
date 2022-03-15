import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../../constants.dart';
import 'package:hive/hive.dart';
import '../../models/home_content.dart';
import '../../server/repository.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../utils/loadingIndicator.dart';
import '../screen/content_country_based_screen.dart';

class AllCountryScreen extends StatefulWidget {
  static final String route = '/AllCountryScreen';
  @override
  _AllCountryScreenState createState() => _AllCountryScreenState();
}

class _AllCountryScreenState extends State<AllCountryScreen> {
  static const int PAGE_SIZE = 100000;
  static const int PAGE_NUMBER = 1;
  static late bool isDark;
  var appModeBox = Hive.box('appModeBox');

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
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_AllCountryScreenState");
    final bool isFromMenu = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      backgroundColor: isDark ? CustomTheme.primaryColorDark : Colors.transparent,
      appBar: _buildAppBar(isFromMenu) as PreferredSizeWidget,
      body: buildUI(),
    );
  }

  _buildAppBar(isFromMenu) {
    if (isFromMenu)
      return AppBar(
        backgroundColor: isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        title: Text(AppContent.countryScreen),
      );
  }

  Widget buildUI() {
    return Container(
      //color: isDark ? CustomTheme.primaryColorDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagewiseGridView.count(
            pageSize: PAGE_SIZE,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.5,
            crossAxisCount: 3,
            itemBuilder: _itemBuilder,
            loadingBuilder: (context) {
              return spinkit;
            },
            pageFuture: (pageIndex) {
              print(pageIndex);
              String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
              return Repository().getCountryList(pageNumber).then((value) => value!);
            }),
      ),
    );
  }

  Widget _itemBuilder(context, AllCountry allCountry, _) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContentCountryBasedScreen(
                    countryID: allCountry.countryId!,
                    countryName: allCountry.name,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            gradient: getRandomColor(),
          ),
          margin: EdgeInsets.only(right: 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.network(
                    allCountry.imageUrl!,
                    width: 35,
                    height: 35,
                  ),
                ),
                HelpMe().space(5.0),
                Text(allCountry.name!, style: CustomTheme.bodyText3White)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
