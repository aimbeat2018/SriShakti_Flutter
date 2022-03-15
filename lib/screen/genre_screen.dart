import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hive/hive.dart';
import '../../models/home_content.dart';
import '../../server/repository.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import 'movie_by_genere_id.dart';

// ignore: must_be_immutable
class GenreScreen extends StatelessWidget {
  static final String route = '/GenreScreen';
  static const int PAGE_SIZE = 100000;
  static const int PAGE_NUMBER = 1;
  bool? isFromMenu;
  bool isDark = Hive.box('appModeBox').get('isDark') ?? false;

  @override
  Widget build(BuildContext context) {
    isFromMenu = ModalRoute.of(context)!.settings.arguments as bool?;
    return Scaffold(
      backgroundColor: isDark ? CustomTheme.primaryColorDark : Colors.transparent,
      appBar: _buildAppBar(isFromMenu),
      body: buildUI(),
    );
  }

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

  _buildAppBar(isFromMenu) {
    if (isFromMenu)
      return AppBar(
        backgroundColor: isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
        title: Text(AppContent.genreScreen),
      );
  }

  Widget buildUI() {
    return Container(
      //color: isDark ? CustomTheme.colorAccentDark : CustomTheme.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagewiseGridView.count(
            pageSize: PAGE_SIZE,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.5,
            crossAxisCount: 3,
            itemBuilder: this._itemBuilder,
            loadingBuilder: (context) {
              return spinkit;
            },
            pageFuture: (pageIndex) {
              print(pageIndex);
              String pageNumber = (pageIndex! * PAGE_NUMBER + 1).toString();
              return Repository().getGenreList(pageNumber).then((value) => value!);
            }),
      ),
    );
  }

  Widget _itemBuilder(context, AllGenre model, _) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          MoviesScreenByGenereID.route,
          arguments: {
            'isPresentAppBar': true,
            'genereID': model.genreId,
            'title': model.name,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            gradient: getRandomColor(),
          ),
          margin: EdgeInsets.only(right: 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.network(
                    model.imageUrl!,
                    width: 35,
                    height: 35,
                  ),
                ),
                Container(
                  child: Text(model.name!, style: CustomTheme.bodyText3White),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
