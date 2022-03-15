import 'package:flutter/material.dart';
import '../../models/home_content.dart';
import '../../screen/tv_series_screen.dart';
import '../../screen/tv_series/tv_series_details_screen.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../widgets/home_screen_more_widget.dart';

// ignore: must_be_immutable
class HomeScreenSeriesList extends StatelessWidget {
  List<Tvseries>? latestTvSeries;
  final String? title;
  final bool isSearchWidget;
  final bool? isDark;
  double? cardWidth;

  HomeScreenSeriesList({required this.latestTvSeries, this.title, this.isSearchWidget = false, this.isDark});

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width / 3.1;
    return Container(
        padding: EdgeInsets.only(left: 2),
        height: 232,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.start,
                    style: isDark!
                        ? CustomTheme.bodyText2White
                        : isSearchWidget
                            ? CustomTheme.bodyText2
                            : CustomTheme.coloredBodyText2,
                  ),
                  if (!isSearchWidget)
                    HomeScreenMoreWidget(
                      routeName: TvSeriesScreen.route,
                    )
                ],
              ),
            ),
            HelpMe().space(5.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: latestTvSeries!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: cardWidth,
                  margin: EdgeInsets.only(right: 2),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TvSerisDetailsScreen(
                                seriesID: latestTvSeries![index].videosId,
                                isPaid: '',
                              )),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Card(
                          elevation: 1,
                          color: isDark! ? CustomTheme.primaryColorDark : Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: Image.network(
                                  latestTvSeries![index].thumbnailUrl!,
                                  fit: BoxFit.fitWidth,
                                  height: 155,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 2),
                                padding: EdgeInsets.only(right: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      latestTvSeries![index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          isDark! ? CustomTheme.smallTextWhite.copyWith(fontSize: 13) : CustomTheme.smallText.copyWith(fontSize: 13),
                                    ),
                                    Row(
                                      children: [
                                        Text(latestTvSeries![index].videoQuality!,
                                            textAlign: TextAlign.start, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                                        Expanded(
                                          child: Text(latestTvSeries![index].release!,
                                              textAlign: TextAlign.end, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
