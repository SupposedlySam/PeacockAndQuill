import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';

abstract class BasePublicViewModel extends ChangeNotifier {
  final IAuthorizationUseCase authorizationUseCase;
  final IPresentationRepository presentationRepository;
  final IUserRepository userRepository;
  bool _isNotValid = false;
  bool get isNotValid => _isNotValid;

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

  Future<void> checkCodeValidity(String presentationCode) async {
    final isValid =
        await presentationRepository.checkPresentationExists(presentationCode);

    if (isValid) {
      final presentationId = await presentationRepository
          .getPresentationIdFromCode(presentationCode);
      userRepository.setActivePresentation(presentationId);
      _isNotValid = false;
    } else {
      _isNotValid = true;
    }
    notifyListeners();
  }

  void storePresentationCode(String presentationCode) {}

  @protected
  void loginWithGoogle() async {
    await authorizationUseCase.googleSignIn();
  }
}
