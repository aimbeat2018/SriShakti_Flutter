import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/video_comments/add_reply_model.dart';
import '../../models/video_comments/all_reply_model.dart';
import '../../server/repository.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/loadingIndicator.dart';
import '../../utils/validators.dart';

class MovieReplyScreen extends StatefulWidget {
  static final String route = "/MovieReplyScreen";

  @override
  _MovieReplyScreenState createState() => _MovieReplyScreenState();
}

class _MovieReplyScreenState extends State<MovieReplyScreen> {
  TextEditingController replyController = new TextEditingController();
  late List<AllReplyModel> allReplyModel;
  late bool isDark;
  @override
  Widget build(BuildContext context) {
    printLog("_MovieReplyScreenState");
    final routes =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isDark = routes['isDark'] ?? false;
    // print(routes['commentsID']);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContent.reply),
        backgroundColor:
            isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      ),
      body: FutureBuilder(
        future: Repository().getAllReply(routes['commentsID']),
        builder:
            (context, AsyncSnapshot<AllReplyModelList?> allReplyModelList) {
          if (allReplyModelList.connectionState == ConnectionState.none &&
              allReplyModelList.data != null) {
            return spinkit;
          }
          if (allReplyModelList.data != null) {
            allReplyModel = allReplyModelList.data!.allReplyList;
            return Container(
              height: MediaQuery.of(context).size.height,
              color: isDark
                  ? CustomTheme.primaryColorDark
                  : CustomTheme.whiteColor,
              child: ListView.builder(
                  itemCount: allReplyModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                child: Image.network(
                                  allReplyModel.elementAt(index).userImgUrl!,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      allReplyModel.elementAt(index).userName!),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                      allReplyModel.elementAt(index).comments!),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Container();
        },
      ),
      bottomSheet: Container(
        color: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: replyController,
                  style: isDark
                      ? CustomTheme.bodyText2White
                      : CustomTheme.bodyText2,
                  decoration: InputDecoration(
                    hintText: AppContent.yourReply,
                    filled: true,
                    hintStyle: CustomTheme.bodyTextgray2,
                    fillColor: isDark ? Colors.black54 : Colors.grey.shade200,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 0.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 0.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Container(
                width: 90.0,
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey.shade300),
                  onPressed: () async {
                    String comments = replyController.text.toString();
                    AddReplyModel? addReplyModel = await Repository().addReplyModel(
                      comment: comments,
                      commentsID: routes['commentsID'],
                      videosID: routes['videosID'],
                      userId: routes['userId'],
                    );
                    replyController.clear();
                    if (addReplyModel != null) {
                      showShortToast(addReplyModel.message!);
                      setState(() {});
                    }
                  },
                  child: Text(
                    AppContent.addReply,
                    style: TextStyle(color: CustomTheme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
