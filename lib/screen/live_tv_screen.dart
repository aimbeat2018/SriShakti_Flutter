import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/all_live_tv_by_category.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/banner_ads.dart';
import '../../widgets/home_screen/live_tv_item.dart';
import '../constants.dart';
import '../strings.dart';

class LiveTvScreen extends StatefulWidget {
  static final route = "/LiveTvScreen";
  @override
  _LiveTvScreenState createState() => _LiveTvScreenState();
}

class _LiveTvScreenState extends State<LiveTvScreen> {
  final tvRepository = Repository();
  List<AllLiveTVChannels>? _list;
  static bool? isDark;
  AuthUser? authUser;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
    authUser = AuthService().getUser();
    if (authUser != null) {}
  }

  @override
  Widget build(BuildContext context) {
    printLog("_LiveTvScreenState");
    final bool isFromMenu = ModalRoute.of(context)!.settings.arguments as bool? ?? false;
    return Scaffold(
      backgroundColor: isDark! ? CustomTheme.primaryColorDark : Colors.transparent,
      appBar: _buildAppBar(isFromMenu),
      body: FutureBuilder<LiveTVListModel?>(
        future: Repository().getAllLiveTV(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              LiveTVListModel listModel = snapshot.data;
              _list = listModel.channels;
              return buildUI(context);
            } else {
              return Center(
                child: Text(AppContent.noItemFound),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(AppContent.somethingWentWrong),
            );
          }

          return Center(
            child: spinkit,
          );
        },
      ),
      // body: BlocProvider(
      //   create: (context) => LiveTvBloc(repository: tvRepository),
      //   child: BlocBuilder<LiveTvBloc, LiveTvState>(
      //     builder: (context, state) {
      //       if (state is LiveTvLoadingState) {
      //         BlocProvider.of<LiveTvBloc>(context).add(FetchAllLiveTVData());
      //       }
      //       if (state is LiveTvErrorState) {
      //         return Center(
      //           child: Text(AppContent.somethingWentWrong),
      //         );
      //       }
      //       if (state is LiveTVLoadedState) {
      //         _list = state.channels;
      //         return buildUI(context);
      //       }
      //       return Center(child: spinkit);
      //     },
      //   ),
      // ),
      bottomSheet: BannerAds(
        isDark: isDark,
      ),
    );
  }

  _buildAppBar(isFromMenu) {
    if (isFromMenu)
      return AppBar(
        backgroundColor: isDark! ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        title: Text(AppContent.liveTvScreen),
      );
  }

  Widget buildUI(BuildContext context) {
    return Container(
      color: isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
      margin: EdgeInsets.only(bottom: 40.0),
      child: CustomScrollView(
        slivers: [
          AllLiveTVList(
            channels: _list,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}
