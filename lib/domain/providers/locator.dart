import 'package:get_it/get_it.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_mobile.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_notifier.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => KeyPressNotifier());
  locator.registerLazySingleton(() => NavBarMobileViewModel(value: false));
}
