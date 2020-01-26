import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';

class PublicViewModel extends BasePublicViewModel {
  final controller = TextEditingController();
  bool _codeIsValid = false;

  PublicViewModel({@required IAuthorizationUseCase authorizationUseCase})
      : super(authorizationUseCase: authorizationUseCase);

  void handleCodeChanged(String val) {
    if (val.isNotEmpty != _codeIsValid) {
      _codeIsValid = val.isNotEmpty;
      notifyListeners();
    }
  }

  VoidCallback get handleLogin => _codeIsValid ? loginWithGoogle : null;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
