import 'package:flutter/material.dart';

import '../app.dart';

class NavigationService {
   GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, String movieId) {
    return navigatorKey.currentState!.pushNamed(routeName,arguments: {"movieID" : movieId});
  }
  Future<dynamic> appRestart(String routeName){
    return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);}
}