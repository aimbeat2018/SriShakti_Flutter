// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigurationModelAdapter extends TypeAdapter<ConfigurationModel> {
  @override
  final int typeId = 0;

  @override
  ConfigurationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigurationModel(
      appConfig: fields[0] as dynamic,
      adsConfig: fields[1] as dynamic,
      paymentConfig: fields[2] as dynamic,
      apkVersionInfo: fields[3] as dynamic,
      genre: fields[4] as dynamic,
      country: fields[5] as dynamic,
      tvCategory: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigurationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.appConfig)
      ..writeByte(1)
      ..write(obj.adsConfig)
      ..writeByte(2)
      ..write(obj.paymentConfig)
      ..writeByte(3)
      ..write(obj.apkVersionInfo)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.tvCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigurationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppConfigAdapter extends TypeAdapter<AppConfig> {
  @override
  final int typeId = 1;

  @override
  AppConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfig(
      menu: fields[0] as dynamic,
      programGuideEnable: fields[1] as dynamic,
      mandatoryLogin: fields[2] as dynamic,
      genreVisible: fields[3] as dynamic,
      countryVisible: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.menu)
      ..writeByte(1)
      ..write(obj.programGuideEnable)
      ..writeByte(2)
      ..write(obj.mandatoryLogin)
      ..writeByte(3)
      ..write(obj.genreVisible)
      ..writeByte(4)
      ..write(obj.countryVisible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AdsConfigAdapter extends TypeAdapter<AdsConfig> {
  @override
  final int typeId = 2;

  @override
  AdsConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsConfig(
      adsEnable: fields[0] as dynamic,
      mobileAdsNetwork: fields[1] as dynamic,
      admobAppId: fields[2] as dynamic,
      admobBannerAdsId: fields[3] as dynamic,
      admobInterstitialAdsId: fields[4] as dynamic,
      fanNativeAdsPlacementId: fields[5] as dynamic,
      fanBannerAdsPlacementId: fields[6] as dynamic,
      fanInterstitialAdsPlacementId: fields[7] as dynamic,
      startappAppId: fields[8] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AdsConfig obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.adsEnable)
      ..writeByte(1)
      ..write(obj.mobileAdsNetwork)
      ..writeByte(2)
      ..write(obj.admobAppId)
      ..writeByte(3)
      ..write(obj.admobBannerAdsId)
      ..writeByte(4)
      ..write(obj.admobInterstitialAdsId)
      ..writeByte(5)
      ..write(obj.fanNativeAdsPlacementId)
      ..writeByte(6)
      ..write(obj.fanBannerAdsPlacementId)
      ..writeByte(7)
      ..write(obj.fanInterstitialAdsPlacementId)
      ..writeByte(8)
      ..write(obj.startappAppId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdsConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentConfigAdapter extends TypeAdapter<PaymentConfig> {
  @override
  final int typeId = 3;

  @override
  PaymentConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentConfig(
      currencySymbol: fields[0] as dynamic,
      currency: fields[1] as dynamic,
      exchnageRate: fields[2] as dynamic,
      paypalEnable: fields[3] as dynamic,
      paypalEmail: fields[4] as dynamic,
      paypalClientId: fields[5] as dynamic,
      stripeEnable: fields[6] as dynamic,
      stripePublishableKey: fields[7] as dynamic,
      stripeSecretKey: fields[8] as dynamic,
      razorpayEnable: fields[9] as dynamic,
      razorpayKeyId: fields[10] as dynamic,
      razorpayKeySecret: fields[11] as dynamic,
      razorpayInrExchangeRate: fields[12] as dynamic,
      offlinePaymentEnable: fields[13] as dynamic,
      offlinePaymentTitle: fields[14] as dynamic,
      offlinePaymentInstruction: fields[15] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentConfig obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.currencySymbol)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.exchnageRate)
      ..writeByte(3)
      ..write(obj.paypalEnable)
      ..writeByte(4)
      ..write(obj.paypalEmail)
      ..writeByte(5)
      ..write(obj.paypalClientId)
      ..writeByte(6)
      ..write(obj.stripeEnable)
      ..writeByte(7)
      ..write(obj.stripePublishableKey)
      ..writeByte(8)
      ..write(obj.stripeSecretKey)
      ..writeByte(9)
      ..write(obj.razorpayEnable)
      ..writeByte(10)
      ..write(obj.razorpayKeyId)
      ..writeByte(11)
      ..write(obj.razorpayKeySecret)
      ..writeByte(12)
      ..write(obj.razorpayInrExchangeRate)
      ..writeByte(13)
      ..write(obj.offlinePaymentEnable)
      ..writeByte(14)
      ..write(obj.offlinePaymentTitle)
      ..writeByte(15)
      ..write(obj.offlinePaymentInstruction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ApkVersionInfoAdapter extends TypeAdapter<ApkVersionInfo> {
  @override
  final int typeId = 4;

  @override
  ApkVersionInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApkVersionInfo(
      versionCode: fields[0] as dynamic,
      versionName: fields[1] as dynamic,
      whatsNew: fields[2] as dynamic,
      apkUrl: fields[3] as dynamic,
      isSkipable: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ApkVersionInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.versionCode)
      ..writeByte(1)
      ..write(obj.versionName)
      ..writeByte(2)
      ..write(obj.whatsNew)
      ..writeByte(3)
      ..write(obj.apkUrl)
      ..writeByte(4)
      ..write(obj.isSkipable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApkVersionInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenreAdapter extends TypeAdapter<Genre> {
  @override
  final int typeId = 5;

  @override
  Genre read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Genre(
      genreId: fields[0] as dynamic,
      name: fields[1] as dynamic,
      description: fields[2] as dynamic,
      slug: fields[3] as dynamic,
      url: fields[4] as dynamic,
      imageUrl: fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Genre obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.genreId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 6;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      countryId: fields[0] as dynamic,
      name: fields[1] as dynamic,
      description: fields[2] as dynamic,
      slug: fields[3] as dynamic,
      url: fields[4] as dynamic,
      imageUrl: fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.countryId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TvCategoryAdapter extends TypeAdapter<TvCategory> {
  @override
  final int typeId = 7;

  @override
  TvCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvCategory(
      liveTvCategoryId: fields[0] as dynamic,
      liveTvCategory: fields[1] as dynamic,
      liveTvCategoryDesc: fields[2] as dynamic,
      status: fields[3] as dynamic,
      slug: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, TvCategory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.liveTvCategoryId)
      ..writeByte(1)
      ..write(obj.liveTvCategory)
      ..writeByte(2)
      ..write(obj.liveTvCategoryDesc)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.slug);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
