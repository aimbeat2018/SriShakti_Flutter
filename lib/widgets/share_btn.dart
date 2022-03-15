import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:package_info/package_info.dart';
import '../strings.dart';

class ShareApp extends StatefulWidget {
  final String? title;
  final Color color;

  const ShareApp({Key? key, required this.title, this.color = Colors.orange})
      : super(key: key);
  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'AppName',
    version: 'Unknown',
    buildNumber: 'Unknown',
    packageName: '',
  );

  @override
  initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String shareText = widget.title! +
            "\n" +
            "${AppContent.shareAppContent}" +
            "\n" +
            "\n" +
            "https://play.google.com/store/apps/details?id=" +
            _packageInfo.packageName;
        Share.share(shareText);
      },
      child: Icon(Icons.share, color: widget.color),
    );
  }
}
