import 'package:flutter/material.dart';
import '../../models/home_content.dart';
import '../../screen/movie_by_genere_id.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../screen/tv_series/tv_series_details_screen.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';

// ignore: must_be_immutable
class HomeScreenGenreMoviesList extends StatelessWidget {
  List<FeaturesGenreAndMovies>? genreMoviesList;
  final bool? isDark;
  double? cardWidth;
  HomeScreenGenreMoviesList({required this.genreMoviesList, required this.isDark});

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width / 3.1;

    return SliverList(
        delegate: SliverChildListDelegate(
            List.generate(genreMoviesList!.length, (index) => buildList(context, genreMoviesList![index], genreMoviesList![index].videos!))
                .toList()));
  }

  Widget buildList(BuildContext context, FeaturesGenreAndMovies featuresGenreAndMovies, List<Movie> moviesList) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
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
                      featuresGenreAndMovies.name!,
                      textAlign: TextAlign.start,
                      style: isDark! ? CustomTheme.bodyText2White : CustomTheme.coloredBodyText2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MoviesScreenByGenereID.route,
                          arguments: {
                            'isPresentAppBar': true,
                            'genereID': featuresGenreAndMovies.genreId,
                            'title': featuresGenreAndMovies.name,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          AppContent.more,
                          textAlign: TextAlign.end,
                          style: CustomTheme.bodyTextgray2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              HelpMe().space(5.0),
              Expanded(
                child: ListView.builder(
                  itemCount: moviesList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: cardWidth,
                    margin: EdgeInsets.only(right: 2),
                    child: InkWell(
                      /*  onTap: () =>
                          print("Clicked on: " + moviesList[index].title),*/
                      onTap: () {
                        switch (moviesList[index].isTvseries) {
                          case "1":
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TvSerisDetailsScreen(
                                          seriesID: moviesList[index].videosId,
                                          isPaid: '',
                                        )),
                              );
                            }
                            break;
                          case "0":
                            {
                              Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": moviesList[index].videosId});
                            }
                            break;

                          default:
                            {
                              //statements;
                              print("tv ot others");
                            }
                            break;
                        }
                      },
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
                                    moviesList[index].thumbnailUrl!,
                                    fit: BoxFit.fitWidth,
                                    height: 155,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 2),
                                  padding: EdgeInsets.only(right: 2, top: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        moviesList[index].title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: isDark!
                                            ? CustomTheme.smallTextWhite.copyWith(fontSize: 13)
                                            : CustomTheme.smallText.copyWith(fontSize: 13),
                                      ),
                                      Row(
                                        children: [
                                          Text(moviesList[index].videoQuality!,
                                              textAlign: TextAlign.start, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                                          Expanded(
                                            child: Text(moviesList[index].release!,
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
          )),
    );
  }
}
