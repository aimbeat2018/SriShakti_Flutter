import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/home_content.dart';
import '../../screen/genre_screen.dart';
import '../../screen/movie_by_genere_id.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../widgets/home_screen_more_widget.dart';

// ignore: must_be_immutable
class HomeScreenGenreList extends StatelessWidget {
  List<AllGenre>? genreList;
  bool? isDark;
  HomeScreenGenreList({required this.genreList, this.isDark});

  final List<LinearGradient> gradientBG = [
    CustomTheme.gradient1,
    CustomTheme.gradient2,
    CustomTheme.gradient3,
    CustomTheme.gradient4,
    CustomTheme.gradient5,
    CustomTheme.gradient6,
  ];

  int index = 0;
  LinearGradient getRandomColor() {
    if (index >= 5) {
      index = 0;
    }
    index++;
    return gradientBG[index];
  }

  @override
  Widget build(BuildContext context) {
    printLog("HomeScreenGenreList");
    return Container(
        padding: EdgeInsets.only(left: 2),
        height: 115,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 6.0, top: 4.0, right: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppContent.exploreByGenre,
                    style: isDark! ? CustomTheme.bodyText2White : CustomTheme.coloredBodyText2,
                  ),
                  HomeScreenMoreWidget(
                    routeName: GenreScreen.route,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: genreList!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MoviesScreenByGenereID.route,
                      arguments: {
                        'isPresentAppBar': true,
                        'genereID': genreList!.elementAt(index).genreId,
                        'title': genreList!.elementAt(index).name,
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        gradient: getRandomColor(),
                      ),
                      margin: EdgeInsets.only(right: 2),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.network(
                                genreList![index].imageUrl!,
                                width: 35,
                                height: 35,
                              ),
                            ),
                            Container(
                              child: Text(genreList![index].name!, style: CustomTheme.bodyText3White),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
