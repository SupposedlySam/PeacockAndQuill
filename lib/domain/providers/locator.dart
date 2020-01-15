import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:peacock_and_quill/data/repositories/firestore/i_presentation_repository.dart';
import 'package:peacock_and_quill/data/repositories/firestore/i_user_repository.dart';
import 'package:peacock_and_quill/data/repositories/firestore/presentation_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/presentation_repository_web.dart';
import 'package:peacock_and_quill/data/repositories/firestore/user_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/user_repository_web.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/logo_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/presentation/components/navigation_bar/logo/logo_web.dart';
import 'package:peacock_and_quill/domain/routing/navigation_interceptor.dart';
import 'package:peacock_and_quill/domain/use_cases/authorization.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_notifier.dart';
import 'package:peacock_and_quill/presentation/view_models/nav_bar_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  _globalKeys();
  _viewModelSetup();
  _useCaseSetup();
  _repositorySetup();
  _otherSetup();
}

void _globalKeys() {
  locator.registerLazySingleton(() => GlobalKey<ScaffoldState>());
  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());
}

void _viewModelSetup() {
  locator.registerLazySingleton(() => KeyPressNotifier());
  locator.registerLazySingleton(() => NavBarViewModel(value: false));
  locator.registerLazySingleton(() => PresenterViewModel());
}

void _useCaseSetup() {
  locator.registerLazySingleton(() => Authorization());
}

void _repositorySetup() {
  locator.registerLazySingleton<IPresentationRepository>(
    () => PresentationRepository(),
  );
  locator.registerLazySingleton<IUserRepository>(
    () => UserRepository(),
  );
}

void _otherSetup() {
  locator.registerLazySingleton<ILogo>(() => Logo());
  locator.registerLazySingleton(() => NavigationInterceptor());
}
