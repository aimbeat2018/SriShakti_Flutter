import 'dart:async';
import 'dart:io';
import '../../strings.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../style/theme.dart';
import '../../widgets/movie_details_video_player.dart';
import '../constants.dart';

class DownloadScreen extends StatefulWidget {
  static final String route = "/RentalHistoryLandingScreen";

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool isDark = Hive.box('appModeBox').get('isDark') ?? false;
  String? _localPath;
  late bool _permissionReady;
  TargetPlatform? platform;
  bool? _isLoading;
  List fileList = [];

  Future<String?> _findLocalPath() async {
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      print("InsidePermissionReady");
      final directory = platform == TargetPlatform.android
          ? await (getExternalStorageDirectory() as FutureOr<Directory>)
          : await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  _prepare() async {
    _localPath =
        (await _findLocalPath())! + Platform.pathSeparator + 'Downloadd';
    print(_localPath);
    final savedDir = Directory(_localPath!);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    fileList = await getTotalDownloadedFile();
    print(fileList.length);
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
  }

  ///Getting Arabic Audio File Directory
  Future<List> getTotalDownloadedFile() async {
    print(_localPath);
    return Directory('$_localPath').list().toList();
  }

  Future<File> _localFile({String? videoName}) async {
    return File('$_localPath$videoName');
  }

  @override
  void initState() {
    _prepare();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_DownloadScreenState");
    platform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
        title: Text(AppContent.downloads),
        backgroundColor:
            isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      ),
      body: Container(
        color: isDark ? CustomTheme.colorAccentDark : CustomTheme.whiteColor,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                AppContent.downloadedFile,
                style:
                    isDark ? CustomTheme.bodyText1White : CustomTheme.bodyText1,
              ),
              if (fileList.length > 0)
                Expanded(
                  child: ListView.builder(
                      itemCount: fileList.length,
                      itemBuilder: (BuildContext context, int index) {
                        String fileName = fileList[index].toString().substring(
                            75, fileList[index].toString().length - 1);
                        return InkWell(
                            onTap: () async {
                              File file =
                                  await _localFile(videoName: '/fileName.mp4');
                              print(await file.lastModified());
                              print(file.lengthSync());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailsVideoPlayerWidget(
                                              localFile: file)));
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.video_collection_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                fileName,
                                style: CustomTheme.bodyText1White,
                              ),
                              subtitle: Text(
                                'Size 150 MB',
                                style: CustomTheme.smallTextWhite,
                              ),
                              trailing: Text(
                                '10/12/20 11:22 am',
                                style: CustomTheme.smallTextWhite,
                              ),
                            ));
                      }),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    AppContent.noFileDownloaded,
                    style: isDark
                        ? CustomTheme.bodyText1White
                        : CustomTheme.bodyText1,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
