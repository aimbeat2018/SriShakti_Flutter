import 'package:flutter/material.dart';
import 'package:oxoo/screen/tv_series/tv_series_details_screen.dart';
import '../../models/home_content.dart';
import '../../screen/movie_screen.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../strings.dart';
import '../../style/theme.dart';

// ignore: must_be_immutable
class HomeScreenMovieList extends StatelessWidget {
  List<Movie>? latestMovies;
  final String? title;
  final bool isSearchWidget;
  final bool? isDark;
  double? cardWidth;

  HomeScreenMovieList({required this.latestMovies, this.context, this.title, this.isSearchWidget = false, this.isDark});
  var context;

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width / 3.1;
    return Container(
        color: isDark! ? CustomTheme.primaryColorDark : null,
        padding: EdgeInsets.only(left: 2),
        height: 235,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 8.0, top: 2.0),
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MoviesScreen.route, arguments: true);
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
            SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: latestMovies!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: cardWidth,
                  margin: EdgeInsets.only(right: 2),
                  child: InkWell(
                    onTap: () {
                      if (latestMovies![index].isTvseries == "1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvSerisDetailsScreen(
                              seriesID: latestMovies![index].videosId,
                              isPaid: '',
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": latestMovies![index].videosId});
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
                                // child: Image.network(
                                //   latestMovies![index].thumbnailUrl!,
                                //   fit: BoxFit.fitWidth,
                                //   height: 155,
                                // ),
                                child: FadeInImage.assetNetwork(
                                    placeholder: "assets/images/placeholder.png",
                                    placeholderScale: 25,
                                    height: 155,
                                    fit: BoxFit.fitWidth,
                                    imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                          "assets/images/placeholder.png",
                                          fit: BoxFit.cover,
                                        ),
                                    image: latestMovies![index].thumbnailUrl!),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 2),
                                padding: EdgeInsets.only(right: 2, top: 2, bottom: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      latestMovies![index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          isDark! ? CustomTheme.smallTextWhite.copyWith(fontSize: 13) : CustomTheme.smallText.copyWith(fontSize: 13),
                                    ),
                                    Row(
                                      children: [
                                        Text(latestMovies![index].videoQuality!,
                                            textAlign: TextAlign.start, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                                        Expanded(
                                          child: Text(latestMovies![index].release!,
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
