import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../screen/auth/auth_screen.dart';
import '../../server/repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';
import '../../models/user_model.dart';
import '../../screen/profile/my_profile_screen.dart';
import '../../screen/search/search_result_screen.dart';
import '../../screen/settings_screen.dart';
import '../../screen/subscription/my_subscription_screen.dart';
import '../../service/authentication_service.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../constants.dart';
import '../strings.dart';
import '../utils/button_widget.dart';
import '../utils/search_text_field.dart';
import '../app.dart';
import '../models/drawer_model.dart';
import 'all_country_screen.dart';
import '../screen/favourite_screen.dart';
import '../screen/genre_screen.dart';
import 'downloads_screen.dart';
import 'live_tv_details_screen.dart';
import 'live_tv_screen.dart';
import 'movie/movie_details_screen.dart';
import 'movie_screen.dart';
import 'tv_series/tv_series_details_screen.dart';
import 'tv_series_screen.dart';
import '../style/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  static final String route = "LandingScreen";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

int selectedIndex = -1;
int savedIndex = 0;

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  FocusNode? myFocusNode;
  final _auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  static bool isDark = false;
  bool activeSearch = false;
  var appModeBox = Hive.box('appModeBox');
  String? userID;
  AuthUser? authUser = AuthService().getUser();
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  List<String> _kProductIdSubscription = <String>['com.zamoo.livedemo.allaccess'];

  @override
  void initState() {
    appModeBox.delete("isUserValidSubscriber");
    _controller = new TabController(vsync: this, length: 5, initialIndex: 1);
    super.initState();
    myFocusNode = FocusNode();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if (visible == false) activeSearch = false;
    });
    isDark = appModeBox.get('isDark') ?? false;
    initStoreInfo();
 /*   SchedulerBinding.instance!.addPostFrameCallback((_) => configOneSignal(context));*/
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> _widgetTitle = ["OXOO", "Movies", "Live TV", "Tv Series", "Favourite"];

  List<Widget> _widgetOptions = <Widget>[HomeScreen(), MoviesScreen(), LiveTvScreen(), TvSeriesScreen(), FavouriteScreen()];

  @override
  void dispose() {
    myFocusNode!.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    printLog("trying_to_submit$value");
    if (value.length > 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultScreen(queryText: value, isDark: isDark)));
    }
  }

  Future<void> configOneSignal(BuildContext context) async {
    await OneSignal.shared.setAppId(Config.oneSignalID);
    OneSignal.shared.setNotificationOpenedHandler((notification) {
      String? id = notification.notification.additionalData!["id"];
      String? type = notification.notification.additionalData!["vtype"];
      printLog("---------ID and Type: {$id $type}");

      switch (type) {
        case "tv":
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiveTvDetailsScreen(
                      liveTvId: id,
                    )),
          );
          break;
        case "movie":
          Navigator.pushNamed(context, MovieDetailScreen.route, arguments: {"movieID": id});
          break;
        case "tvseries":
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TvSerisDetailsScreen(
                      seriesID: id,
                      isPaid: '',
                    )),
          );
          break;
        case "webview":
          _launchURL(id!);
          break;
        default:
          print("type_is_not_movie_event_radio_tv !");
          break;
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    printLog("_LandingScreenState");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _renderAppBar() as PreferredSizeWidget?,
      drawer: Drawer(
        child: Container(
          color: isDark ? CustomTheme.primaryColorDark : CustomTheme.primaryColorRed,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Align(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/logo.png', scale: 6),
                      HelpMe().space(10.0),
                      Text(
                        AppContent.oxooLiveTV,
                        style: CustomTheme.bodyText1White,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(color: isDark ? Colors.grey.shade900 : CustomTheme.primaryColorRed),
              ),
              Container(
                color: isDark ? Colors.transparent : Colors.white,
                height: MediaQuery.of(context).size.height,
                child: authService.getUser() != null ? drawerContent(drawerListItemFirst) : drawerContentWithoutLogin(drawerListItemWithoutLogin),
              )
            ],
          ),
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/bottom_nav/icon_home.png',
              color: CustomTheme.primaryColorRed,
              scale: 3,
            ),
            icon: Image.asset(
              'assets/bottom_nav/icon_home.png',
              color: CustomTheme.grey_transparent2,
              scale: 3,
            ),
            label: AppContent.home,
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/bottom_nav/icon_movie.png',
              color: CustomTheme.primaryColorRed,
              scale: 3,
            ),
            icon: Image.asset(
              'assets/bottom_nav/icon_movie.png',
              color: CustomTheme.grey_transparent2,
              scale: 3,
            ),
            label: AppContent.movies,
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/bottom_nav/icon_tv.png',
              color: CustomTheme.primaryColorRed,
              scale: 3,
            ),
            icon: Image.asset(
              'assets/bottom_nav/icon_tv.png',
              color: CustomTheme.grey_transparent2,
              scale: 3,
            ),
            label: AppContent.live,
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/bottom_nav/icon_tv_series.png',
              color: CustomTheme.primaryColorRed,
              scale: 3,
            ),
            icon: Image.asset(
              'assets/bottom_nav/icon_tv_series.png',
              color: CustomTheme.grey_transparent2,
              scale: 3,
            ),
            label: AppContent.series,
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/bottom_nav/icon_favourite.png',
              color: CustomTheme.primaryColorRed,
              scale: 3,
            ),
            icon: Image.asset(
              'assets/bottom_nav/icon_favourite.png',
              color: CustomTheme.grey_transparent2,
              scale: 3,
            ),
            label: AppContent.favourite,
          ),
        ],
        backgroundColor: isDark ? CustomTheme.primaryColorDark : CustomTheme.whiteColor,
        currentIndex: _selectedIndex,
        selectedItemColor: CustomTheme.primaryColorRed,
        onTap: _onItemTapped,
        unselectedItemColor: CustomTheme.grey_transparent2,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  //renderAppBar
  Widget _renderAppBar() {
    return AppBar(
      backgroundColor: isDark ? CustomTheme.colorAccentDark : CustomTheme.primaryColor,
      title: activeSearch ? appBarSearchWidget() : Text(_widgetTitle.elementAt(_selectedIndex)),
      actions: <Widget>[
        activeSearch
            ? Container()
            : IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    activeSearch = true;
                    myFocusNode!.requestFocus();
                  });
                },
              )
      ],
    );
  }

  //appBarSearchWidget
  appBarSearchWidget() {
    return Container(
        height: 30,
        child: SearchTextField()
            .getCustomEditTextField(style: CustomTheme.bodyText3White, focusNode: myFocusNode, hintValue: " ", onFieldSubmitted: _handleSubmitted));
  }

  //drawerContent
  Widget drawerContent(drawerListItem) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drawerListItem.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 11)
            return ListTile(
              leading: SvgPicture.asset(
                'assets/drawer_icon/${drawerListItem.elementAt(index).navItemIcon}',
                color: CustomTheme.grey_60,
              ),
              title: Container(
                  color: drawerListItem.elementAt(index).isSelected ? Colors.red : Colors.transparent,
                  child: Text(drawerListItem.elementAt(11).navItemName, style: TextStyle(color: CustomTheme.grey_60))),
              trailing: Switch(
                value: isDark,
                activeColor: CustomTheme.primaryColor,
                onChanged: (bool value) {
                  appModeBox.put('isDark', value);
                  setState(() {
                    isDark = value;
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(LandingScreen.route, (Route<dynamic> route) => false);
                },
              ),
            );
          return InkWell(
            child: ListTile(
              tileColor: drawerListItem.elementAt(index).isSelected
                  ? isDark
                      ? Colors.grey.shade900
                      : Colors.grey.shade200
                  : Colors.transparent,
              leading: SvgPicture.asset(
                'assets/drawer_icon/${drawerListItem.elementAt(index).navItemIcon}',
                color: CustomTheme.grey_60,
              ),
              title: Text(
                drawerListItem.elementAt(index).navItemName,
                style: TextStyle(color: drawerListItem.elementAt(index).isSelected ? Colors.red : CustomTheme.grey_60),
              ),
            ),
            onTap: () {
              printLog("index$index");
              setState(() {
                if (savedIndex != -1) {
                  drawerListItem.elementAt(savedIndex).isSelected = false;
                }
                drawerListItem[index].isSelected = true;
                savedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingScreen()), (Route<dynamic> route) => false);
                  break;
                case 1:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MoviesScreen.route, arguments: true);
                  break;
                case 2:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, TvSeriesScreen.route, arguments: true);
                  break;
                case 3:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, LiveTvScreen.route, arguments: true);
                  break;
                case 4:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, GenreScreen.route, arguments: true);

                  break;
                case 5:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AllCountryScreen.route, arguments: true);
                  break;
                case 6:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MyProfileScreen.route);
                  break;
                case 7:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FavouriteScreen.route, arguments: true);
                  break;
                case 8:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MySubscriptionScreen.route);
                  break;
                case 9:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingScreen.route);
                  break;
                case 10:
                  // Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          content: Text(AppContent.areYouSureLogout, style: isDark ? CustomTheme.bodyText2White : CustomTheme.bodyText2),
                          backgroundColor: isDark ? CustomTheme.darkGrey : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                          actionsPadding: EdgeInsets.only(right: 15.0),
                          actions: <Widget>[
                            GestureDetector(
                                onTap: () async {
                                  await _auth.signOut();
                                  if (authService.getUser() != null) authService.deleteUser();
                                  //subscription key will be deleted here
                                  Navigator.of(dialogContext).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (dialogContext) => RenderFirstScreen()), (Route<dynamic> route) => false);
                                },
                                child: HelpMe().accountDeactivate(60, AppContent.yesText, height: 30.0)),
                            SizedBox(width: 8.0),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: HelpMe().submitButton(60, AppContent.noText, height: 30.0)),
                          ],
                        );
                      });
                  break;
                case 12:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, DownloadScreen.route);
                  break;
              }
            },
          );
        });
  }

  //drawerContent
  Widget drawerContentWithoutLogin(drawerListItem) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drawerListItem.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 9)
            return ListTile(
              leading: SvgPicture.asset(
                'assets/drawer_icon/${drawerListItem.elementAt(index).navItemIcon}',
                color: CustomTheme.grey_60,
              ),
              title: Container(
                  color: drawerListItem.elementAt(index).isSelected ? Colors.red : Colors.transparent,
                  child: Text(drawerListItem.elementAt(9).navItemName, style: TextStyle(color: CustomTheme.grey_60))),
              trailing: Switch(
                value: isDark,
                activeColor: CustomTheme.primaryColor,
                onChanged: (bool value) {
                  appModeBox.put('isDark', value);
                  setState(() {
                    isDark = value;
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(LandingScreen.route, (Route<dynamic> route) => false);
                },
              ),
            );
          return InkWell(
            child: ListTile(
              tileColor: drawerListItem.elementAt(index).isSelected
                  ? isDark
                      ? Colors.grey.shade900
                      : Colors.grey.shade200
                  : Colors.transparent,
              leading: SvgPicture.asset(
                'assets/drawer_icon/${drawerListItem.elementAt(index).navItemIcon}',
                color: CustomTheme.grey_60,
              ),
              title: Text(
                drawerListItem.elementAt(index).navItemName,
                style: TextStyle(color: drawerListItem.elementAt(index).isSelected ? Colors.red : CustomTheme.grey_60),
              ),
            ),
            onTap: () {
              printLog("index $index");
              setState(() {
                if (savedIndex != -1) {
                  drawerListItem.elementAt(savedIndex).isSelected = false;
                }
                drawerListItem[index].isSelected = true;
                savedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingScreen()), (Route<dynamic> route) => false);
                  break;
                case 1:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MoviesScreen.route, arguments: true);
                  break;
                case 2:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, TvSeriesScreen.route, arguments: true);
                  break;
                case 3:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, LiveTvScreen.route, arguments: true);
                  break;
                case 4:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, GenreScreen.route, arguments: true);
                  break;
                case 5:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AllCountryScreen.route, arguments: true);
                  break;

                case 6:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FavouriteScreen.route, arguments: true);
                  break;
                case 7:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingScreen.route);
                  break;
                case 8:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AuthScreen.route);
                  break;
                case 10:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, DownloadScreen.route, arguments: {'isDark': isDark});
                  break;
              }
            },
          );
        });
  }

  Future<void> initStoreInfo() async {
    printLog("Inside_initStore!");
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      printLog("connection_not_available");
      return;
    }

    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(_kProductIdSubscription.toSet());
    if (productDetailResponse.error != null) {
      printLog("productDetailResponse_Error");
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      printLog("product_details_empty");
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse = await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {}
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      print(purchase.productID);
      if (await _verifyPurchase(purchase)) {
        print("_verifyPurchase_ok");
        appModeBox.put("isUserValidSubscriber", true);
        verifiedPurchases.add(purchase);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    printLog("purchase:${purchaseDetails.productID}");
    if (Platform.isAndroid) {
      return Repository().verifyMarketInApp(
        signature: purchaseDetails.billingClientPurchase!.signature,
        signedData: purchaseDetails.billingClientPurchase!.originalJson,
        publicKey: Config.publicKeyBase64,
      );
    } else {
      return Future<bool>.value(true);
    }
  }
}
