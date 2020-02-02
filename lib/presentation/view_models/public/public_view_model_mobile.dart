import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';

enum AuthType { apple, google }

class PublicViewModel extends BasePublicViewModel {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  bool _codeIsValid = false;
  bool get codeIsValid => _codeIsValid;

  PublicViewModel({
    @required IAllAuthorizationUseCase authorizationUseCase,
    @required IPresentationRepository presentationRepository,
    @required IUserRepository userRepository,
  }) : super(
            authorizationUseCase: authorizationUseCase,
            presentationRepository: presentationRepository,
            userRepository: userRepository);

  void handleCodeChanged(String val) {
    final isValid = val.isNotEmpty && val.length == 6;
    final isDifferent = isValid != _codeIsValid;
    if (isDifferent) {
      super.resetValidPresentationCode();
      _codeIsValid = isValid;
      validateForm();
      notifyListeners();
    }
  }

  Future<bool> get isAppleLoginEnabled {
    return authorizationUseCase.isAppleLoginEnabled;
  }

  @protected
  Future<AuthResult> loginWithApple() {
    return authorizationUseCase.appleSignIn();
  }

  VoidCallback handle3rdPartyLogin(AuthType authType) => _codeIsValid
      ? () => loginAndValidatePage(
          authType == AuthType.apple ? loginWithApple : loginWithGoogle)
      : null;

  void loginAndValidatePage(Future<AuthResult> Function() loginMethod) async {
    final presentationCode = controller.text;
    final isValidCode = await super.checkCodeValidity(
      presentationCode,
      validateForm,
    );

    if (validateForm() && isValidCode) {
      final authResult = await loginMethod();

      if (authResult != null) {
        final presentationId = await presentationRepository
            .getPresentationIdFromCode(presentationCode);

        userRepository.setActivePresentation(presentationId);
      }
    }
  }

  bool validateForm() => formKey.currentState.validate();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
