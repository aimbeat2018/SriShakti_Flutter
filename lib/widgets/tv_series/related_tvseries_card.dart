import 'package:flutter/material.dart';
import '../../models/tv_series_details_model.dart';
import '../../style/theme.dart';

class RelatedTvSerisCard extends StatelessWidget {
  final RelatedTvseries? relatedTvseries;
  final bool? isDark;
  const RelatedTvSerisCard({Key? key, this.relatedTvseries,this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            color:  isDark! ? CustomTheme.primaryColorDark : Colors.transparent,
            image: DecorationImage(
              image: NetworkImage(relatedTvseries!.thumbnailUrl!),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
        ),
        Container(
            width: 120,
            height: 30,
            decoration: BoxDecoration(
              color:isDark! ? CustomTheme.darkGrey : Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6.0),bottomRight: Radius.circular(6.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0,right: 4.0,top: 4.0,bottom: 12.0),
              child: Text(relatedTvseries!.title!,style: isDark!? CustomTheme.bodyText2White:CustomTheme.bodyText2,),
            ))
      ],
    );
  }
}