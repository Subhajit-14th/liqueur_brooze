import 'package:liqueur_brooze/utlis/assets/app_string.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AppString>(() => AppString());
}
