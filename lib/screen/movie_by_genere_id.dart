import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../../strings.dart';
import 'package:hive/hive.dart';
import '../../models/movie_model.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../server/repository.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../constants.dart';

class MoviesScreenByGenereID extends StatefulWidget {
  static final String route = '/MoviesScreenByGenereID';

  @override
  _MoviesScreenByGenereIDState createState() => _MoviesScreenByGenereIDState();
}

class _MoviesScreenByGenereIDState extends State<MoviesScreenByGenereID> {
  static const int PAGE_SIZE = 100000;
  static const int PAGE_NUMBER = 1;
  static late bool isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
  void initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_MoviesScreenByGenereIDState");
    final routes = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: _buildAppBar(routes['isPresentAppBar'], routes['title']),
      body: buildUI(routes['genereID']),
    );
  }

  Widget buildUI(String? genereId) {
    return Container(
      color: isDark ? CustomTheme.primaryColorDark : Colors.white,
      child: PagewiseGridView.count(
          pageSize: PAGE_SIZE,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.64,
          crossAxisCount: 3,
          noItemsFoundBuilder: this._noItemFounnd,
          itemBuilder: this._itemBuilder,
          loadingBuilder: (context) {
            return Center(child: spinkit);
          },
          pageFuture: (pageIndex) {
            print(pageIndex);
            String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
            return Repository().getMovieByGenereID(pageNumber, genereId).then((value) => value!);
          }),
    );
  }

  _buildAppBar(isPresentAppBar, title) {
    if (isPresentAppBar)
      return AppBar(
        backgroundColor: isDark ? CustomTheme.primaryColorDark : CustomTheme.primaryColor,
        title: Text(title),
      );
  }

  Widget _noItemFounnd(context) {
    return Center(child: Text(AppContent.noItemFound, style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2));
  }

  Widget _itemBuilder(context, MovieModel model, _) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": model.videosId}),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Card(
              color: isDark ? CustomTheme.primaryColorDark : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                    child: Image.network(
                      model.thumbnailUrl!,
                      fit: BoxFit.fill,
                      height: 160,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title!,
                          overflow: TextOverflow.ellipsis,
                          style: isDark ? CustomTheme.smallTextWhite.copyWith(fontSize: 13) : CustomTheme.smallText.copyWith(fontSize: 13),
                        ),
                        Row(
                          children: [
                            Text(model.videoQuality!, textAlign: TextAlign.start, style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText),
                            Expanded(
                              child:
                                  Text(model.release!, textAlign: TextAlign.end, style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText),
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
