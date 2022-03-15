import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../server/repository.dart';
import '../../service/authentication_service.dart';
import '../../style/theme.dart';
import 'package:hive/hive.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../config.dart';
import '../../strings.dart';

//In-app-purchase var
const List<String> _kProductIds = <String>['com.zamoo.livedemo.allaccess'];

class PremiumSubscriptionScreen extends StatefulWidget {
  static final String route = '/PremiumSubscriptionScreen';
  final bool? fromRadioScreen;
  final bool? fromLiveTvScreen;
  final String? radioId;
  final String? liveTvID;
  final String? isPaid;

  const PremiumSubscriptionScreen({Key? key, this.fromRadioScreen, this.fromLiveTvScreen, this.radioId, this.liveTvID, this.isPaid})
      : super(key: key);
  @override
  _PremiumSubscriptionScreenState createState() => _PremiumSubscriptionScreenState();
}

class _PremiumSubscriptionScreenState extends State<PremiumSubscriptionScreen> {
  String? widgetplanId;
  String? currentProductPrice;
  String? currentPlanID;
  int popCount = 0;
  double? screenWidth;
  late bool isDark;
  AuthUser? authUser = AuthService().getUser();
  var appModeBox = Hive.box('appModeBox');
  bool isUserValidSubscriber = false;

  //In-app-purchase var
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  bool _loading = true;

  @override
  void initState() {
    isDark = appModeBox.get('isDark') ?? false;
    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>;
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse = await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    // print("purchaseResponse:${purchaseResponse.pastPurchases.length}");
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _loading = false;
    });
  }

  void _handlePaymentSuccess() async {
    Navigator.of(context).popUntil((_) => popCount++ >= 2);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print("Inside_listen_to_purchase_update");
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            print("Inside_valid");
            deliverProduct(purchaseDetails);
            isUserValidSubscriber = true;
            appModeBox.put('isUserValidSubscriber', true);
          } else {
            print("Inside_not_valid");
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    setState(() {
      _purchases.add(purchaseDetails);

      _handlePaymentSuccess();
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    print("inside_verify_purchase");
    print("signature:${purchaseDetails.billingClientPurchase!.signature}");
    print("originalJson:${purchaseDetails.billingClientPurchase!.originalJson}");
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

  void showPendingUI() {
    setState(() {
    });
  }

  void handleError(IAPError? error) {
    setState(() {
    });
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    // appModeBox.delete('isUserValidSubscriber');
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : CustomTheme.primaryColor,
          title: Image.asset(
            'assets/logo.png',
            scale: 12.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                AppContent.confirmYourDetails,
                style: CustomTheme.bodyText1,
              ),
              SizedBox(
                height: 20.0,
              ),
              //Details
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppContent.plan,
                                style: CustomTheme.bodyText1,
                              ),
                            )),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    AppContent.watchPremiumVideo,
                                    style: CustomTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    AppContent.watchAllPremiumMovies,
                                    style: CustomTheme.authTitleGrey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppContent.email,
                                style: CustomTheme.bodyText1,
                              ),
                            )),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                authUser!.email!,
                                style: CustomTheme.authTitleGrey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    _buildProductList(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppContent.startStreamingNow,
                        style: CustomTheme.authTitleGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                AppContent.bySigingUpYouAgree,
                style: CustomTheme.authTitleGrey,
              )
            ],
          ),
        ));
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(child: (ListTile(leading: CircularProgressIndicator(), title: Text(AppContent.fetchingProducts))));
    }
    if (!_isAvailable) {
      return Card();
    }
    List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found', style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: Text(AppContent.appNeedsConfiguration)));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return ListTile(
            title: Text(
              productDetails.title,
            ),
            subtitle: Text(
              productDetails.description,
            ),
            trailing: previousPurchase != null
                ? Icon(Icons.check)
                : TextButton(
                    child: Text(productDetails.price),
                    style: TextButton.styleFrom(
                      backgroundColor: CustomTheme.primaryColor,
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      print("trying_to_purchase !");
                      currentProductPrice = productDetails.price;
                      currentPlanID = productDetails.id;
                      PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails, applicationUserName: null, sandboxTesting: true);
                      _connection.buyNonConsumable(purchaseParam: purchaseParam);
                    },
                  ));
      },
    ));

    return Card(child: Column(children: <Widget>[] + productList));
  }
}
