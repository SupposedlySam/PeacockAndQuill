import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthorizationUseCase {
  Future<FirebaseUser> get getUser;
  Stream<FirebaseUser> get userStream;

  Future<AuthResult> googleSignIn();
  Future<void> disconnect();
  Future<void> logout();
}
