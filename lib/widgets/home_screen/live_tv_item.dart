import 'package:flutter/material.dart';
import '../../models/all_live_tv_by_category.dart';
import '../../models/home_content.dart';
import '../../screen/live_tv_details_screen.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';

// ignore: must_be_immutable
class HomeScreenLiveTVList extends StatelessWidget {
  List<TvChannels>? tvList;
  final String? title;
  final bool? isSearchWidget;
  final bool? isDark;
  final bool? isFromHomeScreen;

  HomeScreenLiveTVList({required this.tvList, this.title, this.isSearchWidget, this.isDark, this.isFromHomeScreen});

  @override
  Widget build(BuildContext context) {
    return buildTVItem(context, title, tvList, isSearchWidget, isDark!, isFromHomeScreen!);
  }
}

Widget buildTVItem(BuildContext context, heading, List<TvChannels>? tvList, bool? isSearchWidget, bool isDark, bool isFromHomeScreen) {
  return Container(
      height: isFromHomeScreen ? 125 : null,
      padding: EdgeInsets.only(left: 2),
      color: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 10.0),
            child: Text(
              heading,
              textAlign: TextAlign.start,
              style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2,
            ),
          ),
          HelpMe().space(8.0),
          if (isFromHomeScreen)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tvList!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: 140,
                  //height: 50,
                  margin: EdgeInsets.only(right: 2),
                  child: InkWell(
                    onTap: () {
                      print("---------" + tvList.elementAt(index).liveTvId.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LiveTvDetailsScreen(liveTvId: tvList.elementAt(index).liveTvId, isPaid: tvList.elementAt(index).isPaid)));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Card(
                          elevation: 1,
                          color: isDark ? CustomTheme.darkGrey : CustomTheme.whiteColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            child: Image.network(
                              tvList[index].posterUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ),
          if (!isFromHomeScreen)
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.15, crossAxisCount: 3),
              shrinkWrap: true,
              itemCount: tvList!.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  print(tvList.elementAt(index).liveTvId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LiveTvDetailsScreen(liveTvId: tvList.elementAt(index).liveTvId, isPaid: tvList.elementAt(index).isPaid)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    width: 145,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.transparent : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          child: Image.network(
                            tvList[index].posterUrl,
                            fit: BoxFit.fill,
                            width: 220,
                            height: 75,
                          ),
                        ),
                        Text(
                          tvList[index].tvName,
                          maxLines: 1,
                          style: isDark ? CustomTheme.authTitleWhite : CustomTheme.authTitleBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          HelpMe().space(8.0),
        ],
      ));
}

class AllLiveTVList extends StatelessWidget {
  final List<AllLiveTVChannels>? channels;
  final bool? isDark;

  AllLiveTVList({required this.channels, this.isDark});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(
            List.generate(channels!.length, (index) => buildTVItem(context, channels![index].title, channels![index].list, false, isDark!, false))
                .toList()));
  }
}
