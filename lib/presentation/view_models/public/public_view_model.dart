import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';

abstract class BasePublicViewModel extends ChangeNotifier {
  final IAuthorizationUseCase authorizationUseCase;
  final IPresentationRepository presentationRepository;
  final IUserRepository userRepository;
  bool _isValid = true;
  bool get isValid => _isValid;

  BasePublicViewModel({
    @required this.authorizationUseCase,
    @required this.presentationRepository,
    @required this.userRepository,
  });

  double getMaxWidth(BoxConstraints constraints) {
    return constraints.maxWidth > 1000
        ? constraints.maxWidth * .5
        : constraints.maxWidth;
  }

  VoidCallback get handleLogin;

  void resetValidPresentationCode() {
    _isValid = true;
    notifyListeners();
  }

  @protected
  Future<bool> checkCodeValidity(
    String presentationCode, [
    VoidCallback onValueChanged,
  ]) async {
    final isValid =
        await presentationRepository.checkPresentationExists(presentationCode);
    final isDifferent = isValid != _isValid;

    if (isDifferent && isValid) {
      final presentationId = await presentationRepository
          .getPresentationIdFromCode(presentationCode);

      userRepository.setActivePresentation(presentationId);
    }

    if (isDifferent) {
      onValueChanged();
      _isValid = isValid;
      notifyListeners();
    }

    return isValid;
  }

  void storePresentationCode(String presentationCode) {}

  @protected
  void loginWithGoogle() async {
    await authorizationUseCase.googleSignIn();
  }
}
