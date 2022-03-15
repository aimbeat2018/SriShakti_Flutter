// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hive/hive.dart';
import '../../models/configuration.dart';
import '../../models/movie_model.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../server/repository.dart';
import '../../service/get_config_service.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/banner_ads.dart';
import '../constants.dart';

class MoviesScreen extends StatefulWidget {
  static final String route = '/MoviesScreen';
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  static const int PAGE_SIZE = 24;
  static const int PAGE_NUMBER = 1;
  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');
  // late AdmobInterstitial interstitial;
  String? currentMovieId;
  AdsConfig? adsConfig;

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
    adsConfig = GetConfigService().adsConfig();
    /*interstitial = AdmobInterstitial(
      adUnitId: adsConfig!.admobInterstitialAdsId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitial.load();
        handleAdMobEvent(event, args, 'Interstitial');
      },
    );
    interstitial.load();*/
  }

  //AdmobAdEvent will be handled here
  /*void handleAdMobEvent(AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.closed:
        Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": currentMovieId});
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
*/
  @override
  void dispose() {
    // interstitial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_MoviesScreenState");
    final Object isFromMenu = ModalRoute.of(context)!.settings.arguments != null;
    return Scaffold(
      backgroundColor: isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
      appBar: _buildAppBar(isFromMenu),
      body: buildUI(),
      bottomSheet: BannerAds(
        isDark: isDark,
      ),
    );
  }

  Widget buildUI() {
    return PagewiseGridView.count(
        pageSize: PAGE_SIZE,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 0.64,
        crossAxisCount: 3,
        itemBuilder: this._itemBuilder,
        noItemsFoundBuilder: this._noItemFounnd,
        loadingBuilder: (context) {
          return spinkit;
        },
        pageFuture: (pageIndex) {
          print(pageIndex);
          String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
          return Repository().getAllMovies(pageNumber).then((value) => value!);
        });
  }

  _buildAppBar(isFromMenu) {
    if (isFromMenu)
      return AppBar(
        backgroundColor: isDark! ? CustomTheme.primaryColorDark : CustomTheme.primaryColor,
        title: Text(AppContent.movieScreen),
      );
  }

  Widget _noItemFounnd(context) {
    return Center(child: Text(AppContent.noItemFound, style: isDark! ? CustomTheme.bodyText2White : CustomTheme.bodyText2));
  }

  Widget _itemBuilder(context, MovieModel model, _) {
    return InkWell(
      onTap: () async {
        printLog("----------movieScreen: movie item clicked");
        currentMovieId = model.videosId;
        // if (await (interstitial.isLoaded as FutureOr<bool>)) {
        //   printLog("---------ad loaded");
        //   interstitial.show();
        //   return;
        // } else {
        //   Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": currentMovieId});
        // }
        Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": currentMovieId});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Card(
              color: isDark! ? CustomTheme.darkGrey : Colors.white,
              elevation: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                    child: Image.network(
                      model.thumbnailUrl!,
                      fit: BoxFit.fitWidth,
                      height: 145,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    padding: EdgeInsets.only(right: 2, top: 2, bottom: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title!,
                          overflow: TextOverflow.ellipsis,
                          style: isDark! ? CustomTheme.smallTextWhite.copyWith(fontSize: 13) : CustomTheme.smallText.copyWith(fontSize: 13),
                        ),
                        Row(
                          children: [
                            Text(model.videoQuality!,
                                textAlign: TextAlign.start, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                            Expanded(
                              child:
                                  Text(model.release!, textAlign: TextAlign.end, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText),
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
    );
  }
}
