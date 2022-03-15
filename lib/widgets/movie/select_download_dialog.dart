import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/movie_details_model.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';

class SelectDownloadDialog {
  createDialog(context, List<DownloadLinks> downloadLinks, bool? isDark, Function function) {
    print(downloadLinks.length);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              backgroundColor: isDark! ? CustomTheme.darkGrey : Colors.white,
              content: downloadLinks.length > 0
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
                          height: downloadLinks.length > 10 ? MediaQuery.of(context).size.height / 1.5 : 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: downloadLinks.length > 10 ? false : true,
                            itemCount: downloadLinks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: InkWell(
                                  onTap: () {
                                    // print(downloadLinks.elementAt(index).downloadUrl);
                                    HelpMe().launchURL(downloadLinks.elementAt(index).downloadUrl!);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      color: isDark ? CustomTheme.black_window : Colors.grey.shade300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          downloadLinks.elementAt(index).label!,
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
                          height: downloadLinks.length > 10 ? MediaQuery.of(context).size.height / 1.5 : 40 * downloadLinks.length.toDouble(),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: downloadLinks.length > 10 ? false : true,
                            itemCount: downloadLinks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: InkWell(
                                  onTap: () {
                                    if (downloadLinks.elementAt(index).inAppDownload) {
                                      //split file name
                                      String url = downloadLinks.elementAt(index).downloadUrl!;
                                      List<String> splitString = url.split(".");
                                      String fileType = splitString.last;
                                      String label = downloadLinks.elementAt(index).label!;
                                      label = label.toLowerCase();
                                      label = label + ".$fileType";
                                      print("------------$label");
                                      function(downloadLinks.elementAt(index).downloadUrl, label);
                                    } else {
                                      launch(downloadLinks.elementAt(index).downloadUrl!);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      color: isDark ? CustomTheme.black_window : Colors.grey.shade300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          downloadLinks.elementAt(index).label!,
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
