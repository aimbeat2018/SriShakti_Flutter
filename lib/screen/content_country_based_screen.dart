import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxoo/bloc/country_movie/country_movie_bloc.dart';
import '../../bloc/search/search_bloc.dart';
import '../../models/content_by_country_model.dart';
import '../../server/repository.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../widgets/home_screen/movie_item.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class ContentCountryBasedScreen extends StatelessWidget {
  static final String route = '/ContentCountryBasedScreen';
  final String? countryID;
  final String? countryName;
  bool isDark = Hive.box('appModeBox').get('isDark') ?? false;
  ContentCountryBasedScreen({Key? key, this.countryID, this.countryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        title: Text(countryName!),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        color: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
        child: BlocProvider<CountryMovieBloc>(
          create: (context) => CountryMovieBloc(repository: Repository())..add(GetMovieByCountryEvent(countryId: countryID!)),
          child: BlocBuilder<CountryMovieBloc, CountryMovieState>(
            builder: (context, state) {
              if (state is SearchErrorState) {
                return Center(
                  child: Text(AppContent.somethingWentWrong, style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2),
                );
              }
              if (state is CountryMovieLoadedState) {
                return buildUI(context, state.countryModel);
              }
              return Center(
                child: spinkit,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildUI(BuildContext context, ContentByCountryModel contentByCountryModel) {
    if (contentByCountryModel.movieList.length == 0)
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Text("${AppContent.showResultFor}$countryName", style: CustomTheme.bodyText1),
            ),
          ),
          Text(AppContent.noitemshere, style: CustomTheme.bodyTextgray2),
          Align(alignment: Alignment.bottomCenter, child: Image.asset('assets/images/bg_no_item_city.png')),
        ],
      );
    return CustomScrollView(
      slivers: <Widget>[
        if (contentByCountryModel.movieList.length > 0)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 2, bottom: 15),
              child: HomeScreenMovieList(
                latestMovies: contentByCountryModel.movieList,
                context: context,
                title: AppContent.movieList,
                isSearchWidget: true,
                isDark: isDark,
              ),
            ),
          ),
      ],
    );
  }
}
