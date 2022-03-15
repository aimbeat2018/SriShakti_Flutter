import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hive/hive.dart';
import '../../models/movie_model.dart';
import '../../screen/tv_series/tv_series_details_screen.dart';
import '../../server/repository.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/banner_ads.dart';

import '../constants.dart';
import '../strings.dart';

class TvSeriesScreen extends StatefulWidget {
  static final String route = '/TVSerisScreen';

  @override
  _TvSeriesScreenState createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
  static bool isDark = false;
  var appModeBox = Hive.box('appModeBox');
  static const int PAGE_SIZE = 24;
  static const int PAGE_NUMBER = 1;

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_TvSeriesScreenState");
    final bool isFromMenu = ModalRoute.of(context)!.settings.arguments != null;

    return Scaffold(
      backgroundColor: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
      appBar: _buildAppBar(isFromMenu),
      body: Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: PagewiseGridView.count(
            pageSize: PAGE_SIZE,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.64,
            crossAxisCount: 3,
            itemBuilder: this._itemBuilder,
            noItemsFoundBuilder: _noItemFounnd,
            loadingBuilder: (context) {
              return Center(child: spinkit);
            },
            pageFuture: (pageIndex) {
              print(pageIndex);
              String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
              return Repository().getAllTVSeries(pageNumber).then((value) => value!);
            }),
      ),
      bottomSheet: BannerAds(
        isDark: isDark,
      ),
    );
  }

  Widget _noItemFounnd(context) {
    return Center(child: Text("No item Found ! ", style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2));
  }

  _buildAppBar(isFromMenu) {
    if (isFromMenu)
      return AppBar(
        backgroundColor: isDark ? CustomTheme.primaryColorDark : CustomTheme.primaryColor,
        title: Text(AppContent.tvSerisScreen),
      );
  }

  Widget _itemBuilder(context, MovieModel model, _) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TvSerisDetailsScreen(
                  seriesID: model.videosId,
                  isPaid: model.isPaid,
                )),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Card(
            color: isDark ? CustomTheme.darkGrey : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                  child: Image.network(
                    model.thumbnailUrl!,
                    fit: BoxFit.cover,
                    height: 160,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  padding: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title!,
                        overflow: TextOverflow.ellipsis,
                        style: isDark ? CustomTheme.smallTextWhite.copyWith(fontSize: 13) : CustomTheme.smallText.copyWith(fontSize: 13),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.videoQuality!,
                            textAlign: TextAlign.start,
                            style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText,
                          ),
                          Text(
                            model.release!,
                            textAlign: TextAlign.end,
                            style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
