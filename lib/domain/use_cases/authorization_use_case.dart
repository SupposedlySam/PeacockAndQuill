import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_authorization_use_case.dart';

class AuthorizationUseCase implements IAuthorizationUseCase {
  final IUserRepository userRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthorizationUseCase({@required this.userRepository});

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;

  Future<AuthResult> googleSignIn() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleAuth = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      await userRepository.updateUser(authResult);

      return authResult;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> logout() async {
    await _tryDisconnect();
    return _auth.signOut();
  }

  Future _tryDisconnect() async {
    try {
      await _googleSignIn.disconnect();
    } catch (Exception) {}
  }
}