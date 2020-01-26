import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';

class PublicViewModel extends BasePublicViewModel {
  PublicViewModel({@required IAuthorizationUseCase authorizationUseCase})
      : super(authorizationUseCase: authorizationUseCase);

  @override
  VoidCallback get handleLogin {
    return loginWithGoogle;
  }
}
