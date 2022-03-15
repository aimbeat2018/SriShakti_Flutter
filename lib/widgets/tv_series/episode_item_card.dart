import 'package:flutter/material.dart';
import '../../style/theme.dart';
class EpisodeItemCard extends StatelessWidget {
  final String? episodeName;
  final String? imagePath;
  final bool? isDark;

   EpisodeItemCard({Key? key, this.episodeName, this.imagePath, this.isDark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        Container(
            width: 130,
            decoration: BoxDecoration(
              color:isDark! ?CustomTheme.primaryColorDark: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(episodeName!,style:isDark!? CustomTheme.bodyText3White:CustomTheme.bodyText3 ),
            ))
      ],
    );
  }
}