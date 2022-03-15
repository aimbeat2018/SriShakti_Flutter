// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/configuration.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../style/theme.dart';

// ignore: must_be_immutable
class BannerAds extends StatelessWidget {
  AdsConfig? adsConfig;
  final bool? isDark;

  BannerAds({Key? key, required this.isDark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ConfigurationModel>('configBox').listenable(),
      builder: (context, dynamic box, widget) {
        adsConfig = box.get(0).adsConfig;
        if (adsConfig!.adsEnable == "1")
          return Container(
            width: MediaQuery.of(context).size.width,
            color: isDark! ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
            child: Container(
              /*child: AdmobBanner(
                // adUnitId: adsConfig.admobBannerAdsId,
                adUnitId: "ca-app-pub-3940256099942544/6300978111",
                adSize: AdmobBannerSize.BANNER,
              ),*/
            ),
          );
        return Container(
          height: 0.0,
          width: 0.0,
        );
      },
    );
  }
}
