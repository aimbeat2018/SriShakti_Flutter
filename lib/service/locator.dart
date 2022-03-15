import 'package:get_it/get_it.dart';
import '../../service/navigation_servicce.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}