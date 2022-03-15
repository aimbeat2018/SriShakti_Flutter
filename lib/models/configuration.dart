import 'package:hive/hive.dart';
part 'configuration.g.dart';

@HiveType(typeId: 0)
class ConfigurationModel {
  @HiveField(0)
  final appConfig;
  @HiveField(1)
  final adsConfig;
  @HiveField(2)
  final paymentConfig;
  @HiveField(3)
  final apkVersionInfo;
  @HiveField(4)
  final genre;
  @HiveField(5)
  final country;
  @HiveField(6)
  final tvCategory;
  ConfigurationModel({this.appConfig, this.adsConfig, this.paymentConfig,this.apkVersionInfo,this.genre,this.country,this.tvCategory});

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
      appConfig :      json['app_config']         != null ? new AppConfig.fromJson(json['app_config'])            : null,
      adsConfig :      json['ads_config']         != null ? new AdsConfig.fromJson(json['ads_config'])            : null,
      paymentConfig :  json['payment_config']     != null ? new PaymentConfig.fromJson(json['payment_config'])    : null,
      apkVersionInfo : json['apk_version_info']   != null ? new ApkVersionInfo.fromJson(json['apk_version_info']) : null,
      genre :          json['genre']              != null ? new ApkVersionInfo.fromJson(json['apk_version_info']) : null,
      country :        json['country']            != null ? new ApkVersionInfo.fromJson(json['apk_version_info']) : null,
      tvCategory :     json['tv_category']        != null ? new ApkVersionInfo.fromJson(json['apk_version_info']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data                                  = new Map<String, dynamic>();
    if (this.appConfig != null)         {data['app_config']          = this.appConfig.toJson();}
    if (this.adsConfig != null)         {data['ads_config']          = this.adsConfig.toJson();}
    if (this.paymentConfig != null)     {data['payment_config']      = this.paymentConfig.toJson();}
    if (this.apkVersionInfo != null)    {data['apk_version_info']    = this.apkVersionInfo.toJson();}
    if (this.genre != null)             {data['genre']               = this.genre.map((v) => v.toJson()).toList();}
    if (this.country != null)           {data['country']             = this.country.map((v) => v.toJson()).toList();}
    if (this.tvCategory != null)        {data['tv_category']         = this.tvCategory.map((v) => v.toJson()).toList();}
    return data;
  }
}

@HiveType(typeId: 1)
class AppConfig {
  @HiveField(0)
  final menu;

  @HiveField(1)
  final programGuideEnable;

  @HiveField(2)
  final mandatoryLogin;

  @HiveField(3)
  final genreVisible;

  @HiveField(4)
  final countryVisible;

  AppConfig({
    this.menu,
    this.programGuideEnable,
    this.mandatoryLogin,
    this.genreVisible,
    this.countryVisible});

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      menu:               json['menu'],
      programGuideEnable: json['program_guide_enable'],
      mandatoryLogin:     json['mandatory_login'],
      genreVisible:       json['genre_visible'],
      countryVisible:     json['country_visible'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data   = new Map<String, dynamic>();
    data['menu']                      = this.menu;
    data['program_guide_enable']      = this.programGuideEnable;
    data['mandatory_login']           = this.mandatoryLogin;
    data['genre_visible']             = this.genreVisible;
    data['country_visible']           = this.countryVisible;
    return data;
  }
}

@HiveType(typeId: 2)
class AdsConfig {
  @HiveField(0)
  final adsEnable;

  @HiveField(1)
  final mobileAdsNetwork;

  @HiveField(2)
  final admobAppId;

  @HiveField(3)
  final admobBannerAdsId;

  @HiveField(4)
  final admobInterstitialAdsId;

  @HiveField(5)
  final fanNativeAdsPlacementId;

  @HiveField(6)
  final fanBannerAdsPlacementId;

  @HiveField(7)
  final fanInterstitialAdsPlacementId;

  @HiveField(8)
  final startappAppId;

  AdsConfig({this.adsEnable,
    this.mobileAdsNetwork,
    this.admobAppId,
    this.admobBannerAdsId,
    this.admobInterstitialAdsId,
    this.fanNativeAdsPlacementId,
    this.fanBannerAdsPlacementId,
    this.fanInterstitialAdsPlacementId,
    this.startappAppId});

  factory AdsConfig.fromJson(Map<String, dynamic> json) {
    return AdsConfig(
      adsEnable:                               json['ads_enable'],
      mobileAdsNetwork:                        json['mobile_ads_network'],
      admobAppId:                              json['admob_app_id'],
      admobBannerAdsId:                        json['admob_banner_ads_id'],
      admobInterstitialAdsId:                  json['admob_interstitial_ads_id'],
      fanNativeAdsPlacementId:                 json['fan_native_ads_placement_id'],
      fanBannerAdsPlacementId:                 json['fan_banner_ads_placement_id'],
      fanInterstitialAdsPlacementId:           json['fan_interstitial_ads_placement_id'],
      startappAppId:                           json['startapp_app_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data             = new Map<String, dynamic>();
    data['ads_enable']                          = this.adsEnable;
    data['mobile_ads_network']                  = this.mobileAdsNetwork;
    data['admob_app_id']                        = this.admobAppId;
    data['admob_banner_ads_id']                 = this.admobBannerAdsId;
    data['admob_interstitial_ads_id']           = this.admobInterstitialAdsId;
    data['fan_native_ads_placement_id']         = this.fanNativeAdsPlacementId;
    data['fan_banner_ads_placement_id']         = this.fanBannerAdsPlacementId;
    data['fan_interstitial_ads_placement_id']   = this.fanInterstitialAdsPlacementId;
    data['startapp_app_id']                     = this.startappAppId;
    return data;
  }
}

@HiveType(typeId: 3)
class PaymentConfig {
  @HiveField(0)
  final currencySymbol;
  @HiveField(1)
  final currency;
  @HiveField(2)
  final exchnageRate;
  @HiveField(3)
  final paypalEnable;
  @HiveField(4)
  final paypalEmail;
  @HiveField(5)
  final paypalClientId;
  @HiveField(6)
  final stripeEnable;
  @HiveField(7)
  final stripePublishableKey;
  @HiveField(8)
  final stripeSecretKey;
  @HiveField(9)
  final razorpayEnable;
  @HiveField(10)
  final razorpayKeyId;

  @HiveField(11)
  final razorpayKeySecret;

  @HiveField(12)
  final razorpayInrExchangeRate;

  @HiveField(13)
  final offlinePaymentEnable;

  @HiveField(14)
  final offlinePaymentTitle;

  @HiveField(15)
  final offlinePaymentInstruction;


  PaymentConfig(
      {this.currencySymbol,
        this.currency,
        this.exchnageRate,
        this.paypalEnable,
        this.paypalEmail,
        this.paypalClientId,
        this.stripeEnable,
        this.stripePublishableKey,
        this.stripeSecretKey,
        this.razorpayEnable,
        this.razorpayKeyId,
        this.razorpayKeySecret,
        this.razorpayInrExchangeRate,
        this.offlinePaymentEnable,
        this.offlinePaymentTitle,
        this.offlinePaymentInstruction});

  factory PaymentConfig.fromJson(Map<String, dynamic> json) {
    return PaymentConfig(
      currencySymbol            : json['currency_symbol'],
      currency                  : json['currency'],
      exchnageRate              : json['exchnage_rate'],
      paypalEnable              : json['paypal_enable'],
      paypalEmail               : json['paypal_email'],
      paypalClientId            : json['paypal_client_id'],
      stripeEnable              : json['stripe_enable'],
      stripePublishableKey      : json['stripe_publishable_key'],
      stripeSecretKey           : json['stripe_secret_key'],
      razorpayEnable            : json['razorpay_enable'],
      razorpayKeyId             : json['razorpay_key_id'],
      razorpayKeySecret         : json['razorpay_key_secret'],
      razorpayInrExchangeRate   : json['razorpay_inr_exchange_rate'],
      offlinePaymentEnable      : json['offline_payment_enable'],
      offlinePaymentTitle       : json['offline_payment_title'],
      offlinePaymentInstruction : json['offline_payment_instruction'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data       = new Map<String, dynamic>();
    data['currency_symbol']               = this.currencySymbol;
    data['currency']                      = this.currency;
    data['exchnage_rate']                 = this.exchnageRate;
    data['paypal_enable']                 = this.paypalEnable;
    data['paypal_email']                  = this.paypalEmail;
    data['paypal_client_id']              = this.paypalClientId;
    data['stripe_enable']                 = this.stripeEnable;
    data['stripe_publishable_key']        = this.stripePublishableKey;
    data['stripe_secret_key']             = this.stripeSecretKey;
    data['razorpay_enable']               = this.razorpayEnable;
    data['razorpay_key_id']               = this.razorpayKeyId;
    data['razorpay_key_secret']           = this.razorpayKeySecret;
    data['razorpay_inr_exchange_rate']    = this.razorpayInrExchangeRate;
    data['offline_payment_enable']        = this.offlinePaymentEnable;
    data['offline_payment_title']         = this.offlinePaymentTitle;
    data['offline_payment_instruction']   = this.offlinePaymentInstruction;
    return data;
  }
}

@HiveType(typeId: 4)
class ApkVersionInfo {
  @HiveField(0)
  final versionCode;
  @HiveField(1)
  final versionName;
  @HiveField(2)
  final whatsNew;
  @HiveField(3)
  final apkUrl;
  @HiveField(4)
  final isSkipable;

  ApkVersionInfo(
      {this.versionCode,
        this.versionName,
        this.whatsNew,
        this.apkUrl,
        this.isSkipable});

  factory ApkVersionInfo.fromJson(Map<String, dynamic> json) {
    return ApkVersionInfo(
      versionCode       : json['version_code'],
      versionName       : json['version_name'],
      whatsNew          : json['whats_new'],
      apkUrl            : json['apk_url'],
      isSkipable        : json['is_skipable'],);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version_code']            = this.versionCode;
    data['version_name']            = this.versionName;
    data['whats_new']               = this.whatsNew;
    data['apk_url']                 = this.apkUrl;
    data['is_skipable']             = this.isSkipable;
    return data;
  }
}

@HiveType(typeId: 5)
class Genre {
  @HiveField(0)
  final genreId;
  @HiveField(1)
  final name;
  @HiveField(2)
  final description;
  @HiveField(3)
  final slug;
  @HiveField(4)
  final url;
  @HiveField(5)
  final imageUrl;

  Genre({
    this.genreId,
    this.name,
    this.description,
    this.slug,
    this.url,
    this.imageUrl});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      genreId     : json['genre_id'],
      name        : json['name'],
      description : json['description'],
      slug        : json['slug'],
      url         : json['url'],
      imageUrl    : json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_id']                = this.genreId;
    data['name']                    = this.name;
    data['description']             = this.description;
    data['slug']                    = this.slug;
    data['url']                     = this.url;
    data['image_url']               = this.imageUrl;
    return data;
  }
}

@HiveType(typeId: 6)
class Country {
  @HiveField(0)
  final countryId;
  @HiveField(1)
  final name;
  @HiveField(2)
  final description;
  @HiveField(3)
  final slug;
  @HiveField(4)
  final url;
  @HiveField(5)
  final imageUrl;

  Country({
    this.countryId,
    this.name,
    this.description,
    this.slug,
    this.url,
    this.imageUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId   : json['country_id'],
      name        : json['name'],
      description : json['description'],
      slug        : json['slug'],
      url         : json['url'],
      imageUrl    : json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['country_id']              = this.countryId;
  data['name']                    = this.name;
  data['description']             = this.description;
  data['slug']                    = this.slug;
  data['url']                     = this.url;
  data['image_url']               = this.imageUrl;
  return data;
  }
}

@HiveType(typeId: 7)
class TvCategory {
  @HiveField(0)
  final liveTvCategoryId;
  @HiveField(1)
  final liveTvCategory;
  @HiveField(2)
  final liveTvCategoryDesc;
  @HiveField(3)
  final status;
  @HiveField(4)
  final slug;

  TvCategory({
    this.liveTvCategoryId,
    this.liveTvCategory,
    this.liveTvCategoryDesc,
    this.status,
    this.slug});

  factory TvCategory.fromJson(Map<String, dynamic> json) {
    return TvCategory(
      liveTvCategoryId    : json['live_tv_category_id'],
      liveTvCategory      : json['live_tv_category'],
      liveTvCategoryDesc  : json['live_tv_category_desc'],
      status              : json['status'],
      slug                : json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data   = new Map<String, dynamic>();
    data['live_tv_category_id']       = this.liveTvCategoryId;
    data['live_tv_category']          = this.liveTvCategory;
    data['live_tv_category_desc']     = this.liveTvCategoryDesc;
    data['status']                    = this.status;
    data['slug']                      = this.slug;
    return data;
  }
}
