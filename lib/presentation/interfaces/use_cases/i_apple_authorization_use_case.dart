import 'package:firebase_auth/firebase_auth.dart';

abstract class IAppleAuthorizationUseCase {
  Future<bool> get isAppleLoginEnabled;
  Future<AuthResult> appleSignIn();
}
