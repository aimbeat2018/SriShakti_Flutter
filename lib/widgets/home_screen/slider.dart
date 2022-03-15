import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxoo/screen/tv_series/tv_series_details_screen.dart';
import '../../models/home_content.dart';
import '../../screen/live_tv_details_screen.dart';
import '../../screen/movie/movie_details_screen.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class ImageSlider extends StatelessWidget {
  HomeContentSlider? _slider;
  ImageSlider(this._slider);
  List<Slide>? _list;

  @override
  Widget build(BuildContext context) {
    _list = _slider!.slide;
    return CarouselSlider(
      options: CarouselOptions(
        initialPage: 0,
        enableInfiniteScroll: true,
        aspectRatio: 3.0,
        // enlargeCenterPage: true,
        autoPlay: true,
        // enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlayInterval: Duration(seconds: 2),
        scrollDirection: Axis.horizontal,
        // viewportFraction: 1.0,
        height: 170.0,
      ),
      items: _list!.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: InkWell(
                onTap: () {
                  switch (slide.actionType) {
                    case "movie":
                      Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": slide.actionId});
                      break;
                    case "tv":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveTvDetailsScreen(
                            liveTvId: slide.actionId,
                            isPaid: "0",
                          ),
                        ),
                      );
                      break;
                    case "tvseries":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TvSerisDetailsScreen(
                            seriesID: slide.id,
                            isPaid: '',
                          ),
                        ),
                      );
                      break;

                    default:
                      {
                        printLog("Inside_others!");
                      }
                  }
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        if (slide.imageLink != null)
                          Image.network(
                            slide.imageLink!,
                            fit: BoxFit.cover,
                          ),
                        /*if(slide.thumbnailUrl != null)
                        Image.network(
                          slide.thumbnailUrl,
                          fit: BoxFit.cover,
                        ),*/
                        Container(
                          alignment: Alignment.bottomLeft,
//                        margin: EdgeInsets.only(left: 10, bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              slide.title!,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
