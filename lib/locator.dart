import 'package:get_it/get_it.dart';
import 'package:peacock_and_quill/models/navigation_entity.dart';
import 'package:peacock_and_quill/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => NavigationEntity());
}
