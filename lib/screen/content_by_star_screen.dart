import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hive/hive.dart';
import 'package:oxoo/models/movie_model.dart';
import 'package:oxoo/server/repository.dart';
import 'package:oxoo/style/theme.dart';
import 'package:oxoo/utils/loadingIndicator.dart';

import '../strings.dart';
import 'movie/movie_details_screen.dart';

class ContentByStarScreen extends StatefulWidget {
  static final String route = '/ContentByStarScreen';
  final String? starId;
  final String? starName;
  const ContentByStarScreen({Key? key, this.starId, this.starName}) : super(key: key);

  @override
  _ContentByStarScreenState createState() => _ContentByStarScreenState();
}

class _ContentByStarScreenState extends State<ContentByStarScreen> {
  bool isDark = false;
  static const int PAGE_SIZE = 100000;
  static const int PAGE_NUMBER = 1;

  @override
  void initState() {
    isDark = Hive.box('appModeBox').get('isDark') ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: _buildAppBar(true, routes['starName']),
      body: _buildUI(routes["starId"]),
    );
  }

  Widget _buildUI(String? id) {
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
        loadingBuilder: (context) => Center(child: spinkit),
        pageFuture: (pageIndex) {
          String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
          return Repository().getMovieByStarID(pageNumber, id).then((value) => value!);
        },
      ),
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
