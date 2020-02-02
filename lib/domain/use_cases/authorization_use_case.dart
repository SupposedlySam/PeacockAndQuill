import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';

class AuthorizationUseCase implements IAllAuthorizationUseCase {
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
      return null;
    }
  }

  Future<void> disconnect() async {
    try {
      final isSignedIn = await _googleSignIn.isSignedIn();

      if (isSignedIn) {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }
    } catch (e) {}
    await _auth.signOut();
  }

  Future<void> logout() async {
    await userRepository.setActivePresentation('');
    await _auth.signOut();
  }

  Future<bool> get isAppleLoginEnabled async {
    var supportsAppleSignIn = false;

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var version = iosInfo.systemVersion;

      if (version.contains('13') == true) {
        supportsAppleSignIn = true;
      }
    }
    return supportsAppleSignIn;
  }

  Future<AuthResult> appleSignIn() async {
    try {
      final result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          try {
            final appleIdCredential = result.credential;

            final oAuthProvider = OAuthProvider(providerId: "apple.com");
            final AuthCredential credential = oAuthProvider.getCredential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken),
              accessToken:
                  String.fromCharCodes(appleIdCredential.authorizationCode),
            );

            final authResult =
                await FirebaseAuth.instance.signInWithCredential(credential);
            await userRepository.updateUser(authResult);

            return authResult;
          } catch (e) {
            return null;
          }
          break;
        case AuthorizationStatus.error:
        case AuthorizationStatus.cancelled:
          break;
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
