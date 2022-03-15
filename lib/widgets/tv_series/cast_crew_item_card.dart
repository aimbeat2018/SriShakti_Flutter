import 'package:flutter/material.dart';
import 'package:oxoo/screen/content_by_star_screen.dart';
import '../../models/tv_series_details_model.dart';
import '../../style/theme.dart';

class CastCrewCard extends StatelessWidget {
  final CastAndCrew? castAndCrew;
  final bool? isDark;
  const CastCrewCard({Key? key, this.castAndCrew, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ContentByStarScreen.route,
          arguments: {
            "starId": castAndCrew!.starId,
            "starName": castAndCrew!.name,
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(castAndCrew!.imageUrl!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
          ),
          Container(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(castAndCrew!.name!, style: isDark! ? CustomTheme.smallTextWhite : CustomTheme.smallText, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
