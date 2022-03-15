import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../constants.dart';
import '../../models/search_result_model.dart';
import '../../server/repository.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../widgets/home_screen/live_tv_item.dart';
import '../../widgets/home_screen/movie_item.dart';
import '../../widgets/home_screen/tv_series_item.dart';
import '../../widgets/shimmer/home_screen_shimmer.dart';

// ignore: must_be_immutable
class SearchResultScreen extends StatelessWidget {
  SearchResultModel? _resultModel;
  final String? queryText;
  final bool? isDark;
  SearchResultScreen({ this.queryText, this.isDark});

  @override
  Widget build(BuildContext context) {
    printLog("SearchResultScreen");
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDark! ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        title: Text(AppContent.searchResult),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        color: isDark! ? CustomTheme.primaryColorDark : Colors.transparent,
        child: BlocProvider<SearchBloc>(
          create: (context) =>
              SearchBloc(Repository())..add(GetSearchEvent(param: queryText)),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchErrorState) {
                return Center(
                  child: Text(AppContent.somethingWentWrong),
                );
              }
              if (state is SearchIsLoaded) {
                _resultModel = state.searchResultModel;
                return buildUI(context);
              }
              return Center(
                child: HomeScreenShimmer(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildUI(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (_resultModel!.tvChannels!.length == null &&
        // ignore: unnecessary_null_comparison
        _resultModel!.tvSeries!.length == null &&
        // ignore: unnecessary_null_comparison
        _resultModel!.movie!.length == null)
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Text("${AppContent.showResultFor} $queryText",
                  style: CustomTheme.bodyText1),
            ),
          ),
          Text(AppContent.noitemshere, style: CustomTheme.bodyTextgray2),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/bg_no_item_city.png')),
        ],
      );
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: Text("${AppContent.showResultFor}  $queryText",
                style: isDark!
                    ? CustomTheme.bodyText1White
                    : CustomTheme.bodyText1),
          ),
        ),
        if (_resultModel!.movie!.length > 0)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 2, bottom: 15),
              child: HomeScreenMovieList(
                latestMovies: _resultModel!.movie,
                context: context,
                title: AppContent.movieList,
                isSearchWidget: true,
                isDark: isDark,
              ),
            ),
          ),
        if (_resultModel!.tvSeries!.length > 0)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 2, bottom: 15),
              child: HomeScreenSeriesList(
                latestTvSeries: _resultModel!.tvSeries,
                title: AppContent.tvSeries,
                isSearchWidget: true,
                isDark: isDark,
              ),
            ),
          ),
        if (_resultModel!.tvChannels!.length > 0)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 20),
              child: HomeScreenLiveTVList(
                  tvList: _resultModel!.tvChannels,
                  isFromHomeScreen: true,
                  isDark: isDark,
                  title: AppContent.tvChannels,
                  isSearchWidget: true),
            ),
          ),
      ],
    );
  }
}
