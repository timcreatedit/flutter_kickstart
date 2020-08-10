import 'package:get_it/get_it.dart';
import 'package:kickstart/services/dialog_service.dart';
import 'package:kickstart/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Independent Services
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
}
