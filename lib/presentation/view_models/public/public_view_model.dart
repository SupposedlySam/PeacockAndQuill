import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';

abstract class BasePublicViewModel extends ChangeNotifier {
  final IAuthorizationUseCase authorizationUseCase;

  BasePublicViewModel({@required this.authorizationUseCase});

  double getMaxWidth(BoxConstraints constraints) {
    return constraints.maxWidth > 1000
        ? constraints.maxWidth * .5
        : constraints.maxWidth;
  }

  VoidCallback get handleLogin;

  @protected
  void loginWithGoogle() async {
    await authorizationUseCase.googleSignIn();
  }
}
