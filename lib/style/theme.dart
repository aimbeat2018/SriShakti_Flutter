import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
abstract class CustomTheme {
  static const Color primaryColor =   const Color(0xFFea202e);
  static const Color primaryColorRed =  const Color(0xFFea202e);
  static const Color colorAccent = const Color(0xFFDB8501);
  static const Color primaryColorDark =  Colors.black;
  static const Color colorAccentDark =  Colors.black87;
  static const Color paypalColor = const Color(0xff009cde);
  static const Color paypalColorDark = const Color(0xffD39916);
  static const Color stripeColor = const Color(0xff6772e5);
  static const Color raveColor = const Color(0xffDFDFDF);
  static const Color ravColorLight = const Color(0xffECECEC);
  static const Color whiteColor = const Color(0xffECECEC);
  static const Color grey_60 = const Color(0xff666666);
  static Color darkGrey = Colors.grey.shade900 ;
  static const Color black_window = const Color(0xff000000);
  static const Color black_window_light = const Color(0xff000000);
  static const Color grey_transparent2 = const Color(0xE97C7C7C);
  static const Color black_transparent = const Color(0x2D000000);
  static const Color amber_800 = const Color(0xffFF8F00);
  static const Color bottomNavBGColor = const Color(0xffFCFCFF);
  static const Color bottomNavTextColor = const Color(0xff97AAC3);
  static const Color overlayDark = const Color(0x208F94FB);
  static const Color springGreen = const Color(0xff5bc46e);
  static const Color royalBlue = const Color(0xff3c599a);
  static const Color dodgerBlue = const Color(0xff4682e6);
  static const Color salmonColor = const Color(0xfff4574c);
  static const Color lightGray = const Color(0xff97AAC3);
  static const gradient1 = const LinearGradient(
    colors: [Color(0xff355C7D),Color(0xff6C5B7B),Color(0xffC06C84),],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradient2 = const LinearGradient(
    colors: [Color(0xfffc4a1a),Color(0xfff7b733),],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradient3 = const LinearGradient(
    colors: [Color(0xff799F0C),Color(0xffACBB78),],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradient4 = const LinearGradient(
    colors: [Color(0xff1A2980),Color(0xff26D0CE),],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradient5 = const LinearGradient(
    colors: [Color(0xff00467F),Color(0xffA5CC82),],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradient6 = const LinearGradient(
    colors: [Color(0xffc0392b),Color(0xff8e44ad),],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );


  static const nav_bg_gradient = const LinearGradient(
    colors: const [primaryColor, colorAccent],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static TextStyle bodyText1 = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w500,
    color: black_window,
    fontSize: 18,
  );
  static TextStyle bodyText1White = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 18,
  );
  static TextStyle bodyText1Bold = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.bold,
    color: black_window,
    fontSize: 15,
  );
  static TextStyle bodyText1BoldWhite = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.bold,
    color: whiteColor,
    fontSize: 15,
  );
  static TextStyle bodyText2 = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w700,
    color: black_window,
    fontSize: 15,
  );
  static TextStyle bodyText2White = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w700,
    color: whiteColor,
    fontSize: 15,
  );
  static TextStyle bodyTextgray2 = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w700,
    color: grey_60,
    fontSize: 15,
  );
  static TextStyle bodyTextgray = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w300,
    color: Colors.grey.shade500,
    fontSize: 15,
  );
  static TextStyle coloredBodyText1 = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w500,
    color: primaryColor,
    fontSize: 18,
  );
  static TextStyle displayTextColored = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w500,
    color: colorAccent,
    fontSize: 25,
  );
  static TextStyle coloredBodyText2 = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w700,
    color: primaryColorRed,
    fontSize: 15,
  );
  static TextStyle orangeColoredBodyText = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w700,
    color: primaryColor,
    fontSize: 15,
  );
  static TextStyle coloredBodyText2Bold = TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.bold,
    color: colorAccent,
    fontSize: 16,
  );
  static TextStyle coloredBodyText3 = TextStyle(
    fontFamily: 'NunitoSans',
    color: colorAccent,
    fontSize: 12,
  );
  static TextStyle bodyText3 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black_window,
    fontSize: 14,
  );
  static TextStyle bodyText3White = TextStyle(
    fontWeight: FontWeight.w500,
    color: whiteColor,
    fontSize: 14,
  );
  static TextStyle bodyText3Gray = TextStyle(
    fontWeight: FontWeight.w500,
    color: grey_transparent2,
    fontSize: 14,
  );
  static TextStyle bodyTextBold3 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black_window,
    fontSize: 12,
  );

  static TextStyle bodyText2Bold =  TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0);
  static TextStyle bodyText2BoldWhite =  TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Colors.white);
  static TextStyle subText2 = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey_60,
    fontSize: 12,
  );
  static TextStyle subTextBold = TextStyle(
    fontFamily: 'NunitoSans',
    color: black_window,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  static TextStyle subTextBoldWhite = TextStyle(
    fontFamily: 'NunitoSans',
    color: whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static TextStyle coloredSubText = TextStyle(
    fontFamily: 'NunitoSans',
    color: colorAccent,
    fontSize: 14,
  );

  static TextStyle authBtnTitle = TextStyle(
    fontFamily: 'NunitoSans',
    color: whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle authBtnTitleBlack = TextStyle(
    fontFamily: 'NunitoSans',
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle authTitle = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle authTitleWhite = TextStyle(
    fontFamily: 'NunitoSans',
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  static TextStyle authTitleBlack = TextStyle(
    fontFamily: 'NunitoSans',
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  static TextStyle authTitleGrey = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey_transparent2,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textFieldTitlePrimaryColored = TextStyle(
    fontFamily: 'NunitoSans',
    color: colorAccent,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textFieldTitlePrimaryWhite = TextStyle(
    fontFamily: 'NunitoSans',
    color: whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle smallTextGrey = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey_transparent2,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  static TextStyle smallText = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static TextStyle smallTextWhite = TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  static TextStyle smallTextStyleColored = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textStyleWhite15 = TextStyle(
    fontFamily: 'NunitoSans',
    color: whiteColor,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textStyleBlack15 = TextStyle(
    fontFamily: 'NunitoSans',
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  //card boxShadow
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      color: overlayDark,
      offset: Offset(0.0, 3.0),
      blurRadius: 7.0,
    ),
  ];
}
