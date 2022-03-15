import 'package:flutter/material.dart';
import '../../style/theme.dart';
import '../strings.dart';

class HomeScreenMoreWidget extends StatelessWidget {
  final String routeName;

  const HomeScreenMoreWidget({Key? key,required this.routeName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return moreWidget(context);
  }
  moreWidget(context) {
    return  InkWell(
        onTap: (){Navigator.pushNamed(context,routeName,arguments: true);},
        child: Text(AppContent.more, style:CustomTheme.bodyTextgray2));
  }
}
