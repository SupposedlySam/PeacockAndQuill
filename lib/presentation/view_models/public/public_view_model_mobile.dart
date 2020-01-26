import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';

class PublicViewModel extends BasePublicViewModel {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  bool _codeIsValid = false;

  PublicViewModel(
      {@required IAuthorizationUseCase authorizationUseCase,
      @required IPresentationRepository presentationRepository,
      @required IUserRepository userRepository})
      : super(
            authorizationUseCase: authorizationUseCase,
            presentationRepository: presentationRepository,
            userRepository: userRepository);

  void handleCodeChanged(String val) {
    if (val.isNotEmpty != _codeIsValid) {
      _codeIsValid = val.isNotEmpty;
      notifyListeners();
    }
  }

  VoidCallback get handleLogin => _codeIsValid ? loginAndValidatePage : null;

  void loginAndValidatePage() {
    loginWithGoogle();
    formKey.currentState.validate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
