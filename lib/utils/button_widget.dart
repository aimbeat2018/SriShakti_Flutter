import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../style/theme.dart';

class HelpMe{
  Widget submitButton(double? width,String title,{double height = 45}){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: CustomTheme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Center(
          child: Text(title, style: TextStyle(color: Colors.white),
          )),
    );
  }
  Widget accountDeactivate(double? width,String title,{double height = 45}){
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: CustomTheme.salmonColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      width: width,
      child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
  Widget premiumSubscriptionButton(double width,String title,{double height = 45}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: CustomTheme.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: Center(
            child: Text(title, style: CustomTheme.orangeColoredBodyText,
            )),
      ),
    );
  }
  launchURL(String downloadUrl) async {
    String url = downloadUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  space(double space){
    return SizedBox(height:space);
  }
  final List<LinearGradient> gradientBG= [
    CustomTheme.gradient1,
    CustomTheme.gradient2,
    CustomTheme.gradient3,
    CustomTheme.gradient4,
    CustomTheme.gradient5,
    CustomTheme.gradient6,
  ];

  int index = 0;
  LinearGradient getRandomColor() {
    if (index >= 5) {
      index = 0;
    }
    index++;
    return gradientBG[index];
  }
}