import 'package:hive/hive.dart';
import '../../models/configuration.dart';

class GetConfigService{
  //Note getConfigService info
  var getConfigBox = Hive.box<ConfigurationModel>('configBox');
  //Note: add getConfigModel data

  void updateGetConfig(ConfigurationModel configurationModel)async {
    await getConfigBox.put(0, configurationModel);
  }

  //Note: appConfig data from local storage
  AppConfig? appConfig(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.appConfig : null;
  }
  //Note: ads config data from local storage
  AdsConfig? adsConfig(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.adsConfig : null;
  }

  PaymentConfig? paymentConfig(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.paymentConfig : null;
  }
  ApkVersionInfo? apkVersionInfo(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.apkVersionInfo : null;
  }
  Genre? genre(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.genre : null;
  }
  Country? country(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.country : null;
  }

  TvCategory? tvCategory(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0)!.tvCategory : null;
  }

}