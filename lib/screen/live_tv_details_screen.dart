import 'dart:async';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screen/subscription/premium_subscription_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../bloc/live_tv/live_tv_details_bloc.dart';
import '../../models/configuration.dart';
import '../../models/live_tv_details_model.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../service/get_config_service.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../widgets/live_tv/live_tv_channels_card.dart';
import '../../widgets/live_mp4_video_player.dart';
import '../../widgets/share_btn.dart';
import 'auth/auth_screen.dart';
import '../constants.dart';
import '../strings.dart';

class LiveTvDetailsScreen extends StatefulWidget {
  final String? liveTvId;
  final String? isPaid;
  const LiveTvDetailsScreen({Key? key, this.liveTvId, this.isPaid})
      : super(key: key);
  @override
  _LiveTvDetailsScreenState createState() => _LiveTvDetailsScreenState();
}

class _LiveTvDetailsScreenState extends State<LiveTvDetailsScreen> {
  LiveTvDetailsModel? liveTvDetailsModel;
  String? currentliveTvID;
  // late AdmobInterstitial admobInterstitial;
  AdsConfig? adsConfig;
  static late bool isDark;
  var appModeBox = Hive.box('appModeBox');
  bool isUserValidSubscriber = false;

  @override
  void initState() {
    isDark = appModeBox.get('isDark') ?? false;
    isUserValidSubscriber = appModeBox.get('isUserValidSubscriber') ?? false;
    adsConfig = GetConfigService().adsConfig();
    /*admobInterstitial = AdmobInterstitial(
        adUnitId: adsConfig!.admobInterstitialAdsId,
        listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
          if (event == AdmobAdEvent.closed) admobInterstitial.load();
          handleAdMobEvent(event, args, 'Interstitial');
        });
    admobInterstitial.load();*/
    super.initState();
  }

  //AdmobAdEvent will be handled here
  /*void handleAdMobEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.closed:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LiveTvDetailsScreen(liveTvId: currentliveTvID)));
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    printLog("_LiveTvDetailsScreenState");
    final authService = Provider.of<AuthService>(context);
    AuthUser? authUser = authService.getUser();

    return Scaffold(
        backgroundColor:
            isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
        body: BlocProvider<LiveTvDetailsBloc>(
          create: (BuildContext context) => LiveTvDetailsBloc(Repository())
            ..add(GetLiveTvDetailsEvent(
                liveTvId: widget.liveTvId,
                userId: authUser != null ? authUser.userId : null)),
          child: BlocBuilder<LiveTvDetailsBloc, LiveTvDetailsState>(
            builder: (context, state) {
              if (state is LiveTvDetailsIsLoaded) {
                if (state.liveTvDetailsModel != null) {
                  liveTvDetailsModel = state.liveTvDetailsModel;
                  String? url = liveTvDetailsModel!.streamUrl;
                  if (liveTvDetailsModel!.isPaid == "1" && authUser == null) {
                   /* SchedulerBinding.instance!.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthScreen(
                                  fromPaidScreen: true,
                                )),
                      );
                    });*/
                  } else {
                    if (!isUserValidSubscriber && widget.isPaid == "1") {
                      return Scaffold(
                        backgroundColor:
                            isDark ? CustomTheme.black_window : Colors.white,
                        body: subscriptionInfoDialog(
                            context: context,
                            isDark: isDark,
                            userId: authUser!.userId.toString()),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (url != null)
                              VideoPlayerWidget(
                                videoUrl: url,
                              ),
                            // VideoPlayerWidget(videoUrl: "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",),
                            ///video player end
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  elevation: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                          liveTvDetailsModel!.streamLabel!,
                                          style: TextStyle(
                                              color: Colors.orange)))),
                            ),
                            Container(
                              color: isDark
                                  ? CustomTheme.primaryColorDark
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Image.network(
                                            liveTvDetailsModel!.thumbnailUrl!,
                                            scale: 3,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(liveTvDetailsModel!.tvName!,
                                                style: isDark
                                                    ? CustomTheme.bodyText2White
                                                    : CustomTheme.bodyText2),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10.0,
                                                  width: 10.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25.0))),
                                                ),
                                                Text(
                                                    AppContent.watchingLiveOxoo,
                                                    style: isDark
                                                        ? CustomTheme
                                                            .bodyText2White
                                                        : CustomTheme
                                                            .bodyText2),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ShareApp(
                                      title: liveTvDetailsModel!
                                          .currentProgramTitle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(AppContent.nowWatching,
                                  style: isDark
                                      ? CustomTheme.bodyText2White
                                      : CustomTheme.bodyText2),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: isDark
                                      ? CustomTheme.darkGrey
                                      : Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 12.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        liveTvDetailsModel!.currentProgramTime!,
                                        style: TextStyle(
                                            color: CustomTheme.primaryColor),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        liveTvDetailsModel!
                                            .currentProgramTitle!,
                                        style: isDark
                                            ? CustomTheme.bodyText2White
                                            : CustomTheme.bodyText2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            HelpMe().space(10.0),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(liveTvDetailsModel!.description!,
                                    style: isDark
                                        ? CustomTheme.bodyText2White
                                        : CustomTheme.bodyText2)),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppContent.allTvChannels,
                                style: isDark
                                    ? CustomTheme.bodyText2White
                                    : CustomTheme.bodyText2,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              height: 120.0,
                              child: ListView.builder(
                                  itemCount:
                                      liveTvDetailsModel!.allTvChannel!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          currentliveTvID = liveTvDetailsModel!
                                              .allTvChannel!
                                              .elementAt(index)
                                              .liveTvId;
                                          /*if (await (admobInterstitial.isLoaded
                                              as FutureOr<bool>)) {
                                            admobInterstitial.show();
                                          }*/
                                        },
                                        child: LiveTvChannelsCard(
                                          allTvChannel: liveTvDetailsModel!
                                              .allTvChannel!
                                              .elementAt(index),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ));
  }

  ///build subscriptionInfo Dialog
  Widget subscriptionInfoDialog(
      {required BuildContext context, required bool isDark, String? userId}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? CustomTheme.darkGrey : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppContent.youNeedPremium,
                  style: CustomTheme.authTitle,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        primary: CustomTheme.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),),
                        onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PremiumSubscriptionScreen(
                                  fromRadioScreen: false,
                                  fromLiveTvScreen: true,
                                  liveTvID: widget.liveTvId,
                                  isPaid: widget.isPaid)),
                        );
                      },
                      child: Text(AppContent.subscribeToPremium, style: CustomTheme.bodyText3White,),
                    ),
                    SizedBox(width: 30.0,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomTheme.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),),
                        onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppContent.goBack, style: CustomTheme.bodyText3White),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
