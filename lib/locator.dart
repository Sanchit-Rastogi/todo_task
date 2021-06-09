import 'package:get_it/get_it.dart';
import 'package:todo/core/services/provider/theme_provider.dart';
import 'core/viewmodels/profile_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => ThemeProvider());

  locator.registerFactory(() => ProfileModel());
}