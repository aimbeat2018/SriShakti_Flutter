import 'package:flutter/material.dart';
import 'package:oxoo/models/home_content.dart';
import 'package:oxoo/screen/movie/movie_details_screen.dart';
import 'package:oxoo/screen/tv_series/tv_series_details_screen.dart';
import 'package:oxoo/style/theme.dart';

// ignore: must_be_immutable
class MoviePoster extends StatelessWidget {
  Movie movie;
  bool isDark = false;
  MoviePoster({Key? key, required this.movie, required this.isDark}) : super(key: key);

  double? cardWidth;

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width / 3.1;
    return Container(
      width: cardWidth,
      margin: EdgeInsets.only(right: 2),
      child: InkWell(
        onTap: () {
          if (movie.isTvseries == "1") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TvSerisDetailsScreen(
                  seriesID: movie.videosId,
                  isPaid: '',
                ),
              ),
            );
          } else {
            Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": movie.videosId});
          }
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Card(
              color: isDark ? CustomTheme.darkGrey : Colors.white,
              elevation: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                    // child: Image.network(
                    //   movie.thumbnailUrl!,
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
                        image: movie.thumbnailUrl!),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    padding: EdgeInsets.only(right: 2, top: 2, bottom: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title!,
                          overflow: TextOverflow.ellipsis,
                          style: isDark ? CustomTheme.smallTextWhite.copyWith(fontSize: 13) : CustomTheme.smallText.copyWith(fontSize: 13),
                        ),
                        Row(
                          children: [
                            Text(movie.videoQuality!, textAlign: TextAlign.start, style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                            Expanded(
                              child:
                                  Text(movie.release!, textAlign: TextAlign.end, style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText),
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
