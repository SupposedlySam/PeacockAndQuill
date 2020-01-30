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
      final googleAuth = await googleSignInAccount?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final authResult = await _auth.signInWithCredential(credential);
        await userRepository.updateUser(authResult);

        return authResult;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> disconnect() async {
    final isSignedIn = await _googleSignIn.isSignedIn();

    if (isSignedIn) {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }
    await _auth.signOut();
  }

  Future<void> logout() async {
    userRepository.setActivePresentation('');
    return _auth.signOut();
  }
}
