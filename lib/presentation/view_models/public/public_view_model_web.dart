import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';

class PublicViewModel extends BasePublicViewModel {
  PublicViewModel({
    @required IAllAuthorizationUseCase authorizationUseCase,
    @required IPresentationRepository presentationRepository,
    @required IUserRepository userRepository,
  }) : super(
            authorizationUseCase: authorizationUseCase,
            presentationRepository: presentationRepository,
            userRepository: userRepository);

  VoidCallback get handleLogin {
    return loginWithGoogle;
  }
}
