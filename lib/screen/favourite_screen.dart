import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../../models/favourite_model.dart';
import '../../models/user_model.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

// ignore: must_be_immutable
class FavouriteScreen extends StatelessWidget {
  static final String route = '/FavouriteScreen';
  static const int PAGE_SIZE = 100000;
  static const int PAGE_NUMBER = 1;
  var appModeBox = Hive.box('appModeBox');
  AuthUser? authUser = AuthService().getUser();
  late bool isDark;

  @override
  Widget build(BuildContext context) {
    final bool isFromMenu = ModalRoute.of(context)!.settings.arguments as bool? ?? false;
    isDark = appModeBox.get('isDark') ?? false;

    return Scaffold(
      backgroundColor: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
      appBar: _buildAppBar(isFromMenu),
      body: buildUI(),
    );
  }

  _buildAppBar(isFromMenu) {
    if (isFromMenu)
      return AppBar(
        backgroundColor: isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        title: Text(AppContent.favouriteScreen),
      );
  }

  Widget buildUI() {
    return authUser != null
        ? Container(
            color: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
            child: PagewiseGridView.count(
                pageSize: PAGE_SIZE,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.64,
                crossAxisCount: 3,
                itemBuilder: this._itemBuilder,
                loadingBuilder: this._loadingBuilder,
                noItemsFoundBuilder: this._noItemFounnd,
                pageFuture: (pageIndex) {
                  printLog(pageIndex);
                  String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
                  return Repository().favouriteData(authUser!.userId, pageNumber).then((value) => value!);
                }),
          )
        : Center(child: Text(AppContent.noItemFound, style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2));
  }

  Widget _noItemFounnd(context) {
    return Center(child: Text(AppContent.noItemFound, style: isDark ? CustomTheme.bodyText2 : CustomTheme.bodyText2));
  }

  Widget _loadingBuilder(context) {
    return Center(child: spinkit);
  }

  Widget _itemBuilder(context, FavouriteModel model, _) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": model.videosId}),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Card(
            color: isDark ? CustomTheme.darkGrey : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                  child: Image.network(
                    model.thumbnailUrl!,
                    fit: BoxFit.cover,
                    height: 140,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  padding: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title!,
                        overflow: TextOverflow.ellipsis,
                        style: isDark ? CustomTheme.authTitleWhite : CustomTheme.authTitleBlack,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.videoQuality!,
                            textAlign: TextAlign.start,
                            style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText,
                          ),
                          Text(
                            model.release!,
                            textAlign: TextAlign.end,
                            style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallText,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
