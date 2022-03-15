import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import '../../service/authentication_service.dart';
import 'package:hive/hive.dart';
import '../../screen/terms_polices.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import 'package:package_info/package_info.dart';
import '../../utils/button_widget.dart';
import '../constants.dart';

class SettingScreen extends StatefulWidget {
  static final String route = "/SettingScreen";
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? output = "";
  PackageInfo _packageInfo = PackageInfo(
    appName: 'AppName',
    version: 'Unknown',
    buildNumber: 'Unknown',
    packageName: '',
  );

  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');
  AuthService authService = AuthService();
  bool _switchValue = true;

  @override
  initState() {
    super.initState();
    _initPackageInfo();
    isDark = appModeBox.get('isDark') ?? false;
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    printLog("_SettingScreenState");
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContent.settings),
        backgroundColor:
            isDark! ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      ),
      body: Container(
        color: isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                AppContent.notification,
                style: CustomTheme.coloredBodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppContent.pushNotification,
                    style: isDark!
                        ? CustomTheme.bodyText2White
                        : CustomTheme.bodyText2Bold,
                  ),
                  Switch(
                    activeColor: CustomTheme.primaryColor,
                    inactiveThumbColor: Colors.grey.shade100,
                    inactiveTrackColor: Colors.grey,
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            _divider(isDark),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                AppContent.others,
                style: CustomTheme.coloredBodyText1,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppContent.contactUs,
                      style: isDark!
                          ? CustomTheme.bodyText2BoldWhite
                          : CustomTheme.bodyText2Bold),
                  Text(
                    AppContent.infoAddress,
                    style: isDark!
                        ? CustomTheme.bodyText3White
                        : CustomTheme.bodyText3,
                  ),
                ],
              ),
            ),
            _divider(isDark),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppContent.copyright,
                      style: isDark!
                          ? CustomTheme.bodyText2BoldWhite
                          : CustomTheme.bodyText2Bold),
                  HelpMe().space(8.0),
                  Text(
                    AppContent.copyrightText,
                    style: isDark!
                        ? CustomTheme.bodyText3White
                        : CustomTheme.bodyText3,
                  ),
                  HelpMe().space(8.0),
                  Text(
                    AppContent.allRightReserved,
                    style: isDark!
                        ? CustomTheme.bodyText3White
                        : CustomTheme.bodyText3,
                  ),
                ],
              ),
            ),
            _divider(isDark),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppContent.version,
                      style: isDark!
                          ? CustomTheme.bodyText2BoldWhite
                          : CustomTheme.bodyText2Bold),
                  Text(
                    "${_packageInfo.version}(${_packageInfo.buildNumber})",
                    style: isDark!
                        ? CustomTheme.bodyText3White
                        : CustomTheme.bodyText3,
                  ),
                ],
              ),
            ),
            _divider(isDark),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, TermsPolices.route);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Text(AppContent.termsPolices,
                    style: isDark!
                        ? CustomTheme.bodyText2BoldWhite
                        : CustomTheme.bodyText2Bold),
              ),
            ),
            _divider(isDark),
            InkWell(
              onTap: () {
                AppReview.storeListing.then((onValue) {
                  setState(() {
                    output = onValue;
                  });
                  print(onValue);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Text(AppContent.shareThisApp,
                    style: isDark!
                        ? CustomTheme.bodyText2BoldWhite
                        : CustomTheme.bodyText2Bold),
              ),
            ),
            _divider(isDark),
          ],
        ),
      ),
    );
  }

  _divider(bool? isDark) {
    return Divider(color: CustomTheme.grey_60);
  }
}
