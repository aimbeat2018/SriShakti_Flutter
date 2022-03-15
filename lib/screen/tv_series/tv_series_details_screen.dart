import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screen/auth/auth_screen.dart';
import '../../screen/subscription/premium_subscription_screen.dart';
import '../../utils/button_widget.dart';
import '../../widgets/tv_series/related_tvseries_card.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../bloc/tv_seris/tv_seris_bloc.dart';
import '../../models/video_comments/all_comments_model.dart';
import '../../models/configuration.dart';
import '../../models/tv_series_details_model.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../service/get_config_service.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/live_mp4_video_player.dart';
import '../../widgets/share_btn.dart';
import '../../widgets/tv_series/cast_crew_item_card.dart';
import '../../widgets/tv_series/episode_item_card.dart';
import '../../constants.dart';
import '../../strings.dart';

class TvSerisDetailsScreen extends StatefulWidget {
  final String? seriesID;
  final String? isPaid;
  const TvSerisDetailsScreen({Key? key, required this.seriesID, required this.isPaid}) : super(key: key);
  @override
  _TvSerisDetailsScreenState createState() => _TvSerisDetailsScreenState();
}

class _TvSerisDetailsScreenState extends State<TvSerisDetailsScreen> {
  TvSeriesDetailsModel? tvSeriesDetailsModel;
  TextEditingController editingController = new TextEditingController();
  Season? selectedSeason;
  String selectedSeasonName = "";
  bool isSeriesPlaying = false;
  String? _url;
  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');
  bool isLoadingBraintree = false;
  AuthUser? authUser = AuthService().getUser();
  bool isUserValidSubscriber = false;

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
    isUserValidSubscriber = appModeBox.get('isUserValidSubscriber') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_TvSerisDetailsScreenState");

    final configService = Provider.of<GetConfigService>(context);
    PaymentConfig? paymentConfig = configService.paymentConfig();

    return Scaffold(
      backgroundColor: isDark! ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      body: BlocProvider<TvSerisBloc>(
        create: (BuildContext context) =>
            TvSerisBloc(Repository())..add(GetTvSerisEvent(seriesId: widget.seriesID, userId: authUser != null ? authUser!.userId.toString() : null)),
        child: BlocBuilder<TvSerisBloc, TvSerisState>(
          builder: (context, state) {
            if (state is TvSerisIsLoaded) {
              if (widget.isPaid == "1" && authUser == null) {
                /*SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthScreen(
                        fromPaidScreen: true,
                      ),
                    ),
                  );
                });*/
              } else {
                tvSeriesDetailsModel = state.tvSeriesDetailsModel;
                print("isPaid:${tvSeriesDetailsModel!.isPaid}");
                if (!isUserValidSubscriber && tvSeriesDetailsModel!.isPaid == "1") {
                  return Scaffold(
                    backgroundColor: isDark! ? CustomTheme.black_window : Colors.white,
                    body: subscriptionInfoDialog(context: context, isDark: isDark!, userId: authUser!.userId.toString()),
                  );
                } else {
                  if (state.tvSeriesDetailsModel != null) {
                    tvSeriesDetailsModel = state.tvSeriesDetailsModel;

                    if (tvSeriesDetailsModel != null) {
                      if (tvSeriesDetailsModel!.season!.length > 0) {
                        selectedSeason = tvSeriesDetailsModel!.season!.elementAt(0);
                      }
                      return Stack(
                        children: [
                          buildUI(context, authUser, paymentConfig, tvSeriesDetailsModel!.videosId),
                          if (isLoadingBraintree) spinkit,
                        ],
                      );
                    }
                    return Center(
                      child: Text(AppContent.loadingData),
                    );
                  }
                }
                return Center(
                  child: spinkit,
                );
              }
            }
            return Center(child: spinkit);
          },
        ),
      ),
    );
  }

  ///build subscriptionInfo Dialog
  Widget subscriptionInfoDialog({required BuildContext context, required bool isDark, String? userId}) {
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
                  "You need Premium membership to watch this video",
                  style: CustomTheme.authTitle,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: CustomTheme.primaryColor,),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumSubscriptionScreen(fromRadioScreen: false, fromLiveTvScreen: true, liveTvID: "1", isPaid: widget.isPaid)),);
                      },
                      child: Text("subscribe to Premium", style: CustomTheme.bodyText3White,),
                    ),
                    SizedBox(width: 30.0,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: CustomTheme.primaryColor,),
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

  Widget buildUI(BuildContext context, AuthUser? authUser, PaymentConfig? paymentConfig, String? videoId) {
    return FutureBuilder(
      future: Repository().getAllComments(videoId),
      builder: (context, AsyncSnapshot<AllCommentModelList?> allCommentModelList) {
        // ignore: unnecessary_null_comparison
        if (allCommentModelList.connectionState == ConnectionState.none && allCommentModelList.hasData == null) {
          return Container();
        }
        return Scaffold(
          body: Container(
            color: isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///here direct tv
                  if (_url != null && isSeriesPlaying)
                    VideoPlayerWidget(
                      videoUrl: _url,
                    ),

                  ///video player end
                  if (!isSeriesPlaying)
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 330.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(tvSeriesDetailsModel!.posterUrl!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),   
                                ),
                                Container(
                                  height: 330.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black87,
                                        Colors.black87,
                                        isDark! ? Colors.black : Colors.white,
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  width: 140,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                      image: DecorationImage(image: NetworkImage(tvSeriesDetailsModel!.thumbnailUrl!), fit: BoxFit.fill)),
                                ),
                                Container(
                                  height: 200.0,
                                  alignment: Alignment.bottomLeft,
                                  margin: new EdgeInsets.only(left: 10),
                                  width: 150.0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        tvSeriesDetailsModel!.title!,
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      HelpMe().space(8.0),
                                      Text(
                                        tvSeriesDetailsModel!.slug!,
                                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                              ShareApp(
                                title: tvSeriesDetailsModel!.title,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  HelpMe().space(20.0),
                  if (selectedSeason != null)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: MediaQuery.of(context).size.width,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: new DropdownButton<Season>(
                            // value: selectedSeason,
                            hint: Text(
                              selectedSeasonName,
                              style: TextStyle(color: Colors.white),
                            ),
                            isExpanded: true,
                            underline: Container(
                              width: 0.0,
                              height: 0.0,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selectedSeason = newValue;
                                selectedSeasonName = newValue!.seasonsName!;
                              });
                            },
                            items: tvSeriesDetailsModel!.season!.map((season) {
                              return new DropdownMenuItem<Season>(
                                value: season,
                                child: new Text(
                                  "Season: " + season.seasonsName!,
                                  style: new TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  if (selectedSeason != null)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 170.0,
                      child: ListView.builder(
                          itemCount: selectedSeason!.episodes!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                print("tapped_on_episodeItem_card");
                                _url = selectedSeason!.episodes![index].fileUrl;
                                isSeriesPlaying = true;
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: EpisodeItemCard(
                                  episodeName: selectedSeason!.episodes!.elementAt(index).episodesName,
                                  imagePath: selectedSeason!.episodes!.elementAt(index).imageUrl,
                                  isDark: isDark,
                                ),
                              ),
                            );
                          }),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tvSeriesDetailsModel!.description!, style: isDark! ? CustomTheme.bodyText2White : CustomTheme.bodyText2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppContent.director,
                      style: isDark! ? CustomTheme.bodyText1BoldWhite : CustomTheme.bodyText1Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${AppContent.releaseOn} 2001-11-05",
                      style: isDark! ? CustomTheme.bodyText1BoldWhite : CustomTheme.bodyText1Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppContent.genre,
                      style: isDark! ? CustomTheme.bodyText1BoldWhite : CustomTheme.bodyText1Bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppContent.castCrew,
                      style: isDark! ? CustomTheme.bodyText1BoldWhite : CustomTheme.bodyText1Bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 120.0,
                    child: ListView.builder(
                        itemCount: tvSeriesDetailsModel!.castAndCrew!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return CastCrewCard(
                            castAndCrew: tvSeriesDetailsModel!.castAndCrew!.elementAt(index),
                            isDark: isDark,
                          );
                        }),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppContent.youMayAlsoLike,
                      style: isDark! ? CustomTheme.bodyText1BoldWhite : CustomTheme.bodyText1Bold,
                    ),
                  ),
                  if (tvSeriesDetailsModel!.relatedTvseries != null)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 200.0,
                      child: ListView.builder(
                          itemCount: tvSeriesDetailsModel!.relatedTvseries!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RelatedTvSerisCard(
                                relatedTvseries: tvSeriesDetailsModel!.relatedTvseries!.elementAt(index),
                                isDark: isDark,
                              ),
                            );
                          }),
                    ),
                  Padding(padding: const EdgeInsets.all(8.0), child: Text(AppContent.comments, style: isDark! ? CustomTheme.bodyText1BoldWhite : CustomTheme.bodyText1Bold,),),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style: isDark! ? CustomTheme.bodyText2White : CustomTheme.bodyText2,
                      controller: editingController,
                      decoration: InputDecoration(
                        hintText: AppContent.yourComments,
                        filled: true,
                        hintStyle: CustomTheme.bodyTextgray2,
                        fillColor: isDark! ? Colors.black54 : Colors.grey.shade200,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: isDark! ? CustomTheme.grey_transparent2 : Colors.grey.shade300,),
                        onPressed: () {
                          print("Add Comments Pressed ");
                        },
                        child: Text(
                          AppContent.addComments,
                          style: TextStyle(color: CustomTheme.primaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
