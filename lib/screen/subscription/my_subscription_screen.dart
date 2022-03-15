import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screen/subscription/premium_subscription_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../service/authentication_service.dart';
import '../../strings.dart';
import '../../style/theme.dart';
import '../../utils/button_widget.dart';
import '../../constants.dart';

class MySubscriptionScreen extends StatefulWidget {
  static final String route = "/MySubscriptionScreen";
  @override
  _MySubscriptionScreenState createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  late bool isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
  initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_MySubscriptionScreenState");
    final authService = Provider.of<AuthService>(context);
    AuthUser authUser = authService.getUser()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContent.mySubsCription),
        backgroundColor: isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: isDark ? CustomTheme.primaryColorDark : Colors.white,
        child: Column(
          children: [
            _space(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${AppContent.userName}${authUser.name}", style:isDark ? CustomTheme.bodyText3White : CustomTheme.bodyText3,),
                  _space(4),
                  Text("${AppContent.email}${authUser.email}", style:isDark ? CustomTheme.bodyText3White : CustomTheme.bodyText3,),
                ],
              ),
            ),
            _space(40),
            InkWell(
                onTap: () {Navigator.pushNamed(context, PremiumSubscriptionScreen.route);},
                child: HelpMe().submitButton(300,AppContent.upgradePurchase)),
          ],
        ),
      ),
    );
  }

  _space(double space) {
    return SizedBox(height: space);
  }
}
