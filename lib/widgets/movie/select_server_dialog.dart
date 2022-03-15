import 'package:flutter/material.dart';
import 'package:oxoo/constants.dart';
import '../../models/videos.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../movie_details_video_player.dart';
import 'movie_details_youtube_player.dart';

class SelectServerDialog {
  createDialog(context, List<Videos> videos, bool? isDark) {
    print(videos.length);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              backgroundColor: isDark! ? CustomTheme.darkGrey : Colors.white,
              content: videos.length > 0
                  ? Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppContent.selectServer,
                            style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.clear,
                                color: CustomTheme.whiteColor,
                              )),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      if (MediaQuery.of(context).orientation == Orientation.landscape)
                        Container(
                          height: videos.length > 10 ? MediaQuery.of(context).size.height / 1.5 : 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: videos.length > 10 ? false : true,
                            itemCount: videos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: InkWell(
                                  onTap: () {
                                    //Navigator.of(context).pop();
                                    printLog("--------------servertype: ${videos.elementAt(index).fileType}");
                                    switch (videos.elementAt(index).fileType!.toLowerCase()) {
                                      case "youtube":
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDetailsYoutubePlayer(url: videos.elementAt(index).fileUrl)));
                                        }
                                        break;
                                      case "mp4":
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDetailsVideoPlayerWidget(videoUrl: videos.elementAt(index).fileUrl)));
                                          //statements;
                                        }
                                        break;
                                      default:
                                        {
                                          //statements;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDetailsVideoPlayerWidget(videoUrl: videos.elementAt(index).fileUrl)));
                                        }
                                        break;
                                    }
                                  },
                                  child: Container(
                                      color: isDark ? CustomTheme.black_window : Colors.grey.shade300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          videos.elementAt(index).label!,
                                          style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallTextGrey,
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                      if (MediaQuery.of(context).orientation == Orientation.portrait)
                        Container(
                          height: videos.length > 10 ? MediaQuery.of(context).size.height / 1.5 : 40 * videos.length.toDouble(),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: videos.length > 10 ? false : true,
                            itemCount: videos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: InkWell(
                                  onTap: () {
                                    print("---------video_url:${videos.elementAt(index).fileUrl}");
                                    Navigator.of(context).pop();
                                    switch (videos.elementAt(index).fileType!.toLowerCase()) {
                                      case "youtube":
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDetailsYoutubePlayer(url: videos.elementAt(index).fileUrl)));
                                        }
                                        break;

                                      case "mp4":
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDetailsVideoPlayerWidget(videoUrl: videos.elementAt(index).fileUrl)));
                                          //statements;
                                        }
                                        break;
                                      default:
                                        {
                                          //statements;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDetailsVideoPlayerWidget(videoUrl: videos.elementAt(index).fileUrl)));
                                        }
                                        break;
                                    }
                                  },
                                  child: Container(
                                      color: isDark ? CustomTheme.black_window : Colors.grey.shade300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          videos.elementAt(index).label!,
                                          style: isDark ? CustomTheme.smallTextWhite : CustomTheme.smallTextGrey,
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                    ])
                  : Text(
                      AppContent.noServerFound,
                      textAlign: TextAlign.center,
                      style: isDark ? CustomTheme.bodyText3White : CustomTheme.bodyText3,
                    ),
            ),
          );
        });
  }
}
