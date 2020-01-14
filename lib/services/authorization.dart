import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peacock_and_quill/interfaces/i_firestore.dart';

class Authorization {
  final IFirestore firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Authorization({@required this.firestore});

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<AuthResult> googleSignIn() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleAuth = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      await firestore.updateUser(authResult);

      return authResult;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    return _auth.signOut();
  }
}
