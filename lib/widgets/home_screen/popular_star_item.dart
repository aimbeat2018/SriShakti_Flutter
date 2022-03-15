import 'package:flutter/material.dart';
import '../../screen/movies_by_star_id.dart';
import 'package:hive/hive.dart';
import '../../models/home_content.dart';
import '../../screen/all_country_screen.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../widgets/home_screen_more_widget.dart';

// ignore: must_be_immutable
class HomeScreenPopularStarList extends StatefulWidget {
  HomeScreenPopularStarList({required this.popularStarList});
  int index = 0;
  List<PopularStars> popularStarList;

  @override
  _HomeScreenCountryListState createState() => _HomeScreenCountryListState();
}

class _HomeScreenCountryListState extends State<HomeScreenPopularStarList> {
  static late bool isDark ;
  var appModeBox = Hive.box('appModeBox');

@override
  void initState() {
  isDark = appModeBox.get('isDark')??false;
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 2),
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 6.0,right: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppContent.popularStars, style:isDark? CustomTheme.bodyText2White:CustomTheme.coloredBodyText2,),
                    HomeScreenMoreWidget(routeName: AllCountryScreen.route,)
                  ],
                )),
            SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.popularStarList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, MoviesScreenByStarID.route,
                          arguments: {
                            'isPresentAppBar': true,
                            'starID': widget.popularStarList.elementAt(index).starId,
                            'title': widget.popularStarList.elementAt(index).starName,
                          },
                        );
                      },
                      child: Container(
                        width: 120.0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.network(widget.popularStarList[index].imageUrl!,width: 90.0,height: 90.0,fit: BoxFit.fill,),),
                            ),
                            Text(widget.popularStarList[index].starName!,style:isDark? CustomTheme.bodyText2White:CustomTheme.coloredBodyText2,textAlign:TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ));
  }
}

