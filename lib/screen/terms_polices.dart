import 'package:flutter/material.dart';
import '../../style/theme.dart';
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../config.dart';
import '../strings.dart';

// ignore: must_be_immutable
class TermsPolices extends StatelessWidget {
  static final String route = "TermsPolices";
  String _url = Config.termsPolicyUrl;
  bool isLoading = true;
  static bool isDark  = Hive.box('appModeBox').get('isDark')??false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContent.termsPolicy),
        backgroundColor:isDark? CustomTheme.colorAccentDark:CustomTheme.primaryColor,
      ),
      body: WebView(
      initialUrl: _url,
    ),
    );
  }
}
