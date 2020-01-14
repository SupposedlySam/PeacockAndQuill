import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/interfaces/i_firestore.dart';
import 'package:peacock_and_quill/models/firebase/user.dart' as m;

class Firestore implements IFirestore {
  void init() {
    if (apps.isEmpty) {
      initializeApp(
        apiKey: "AIzaSyC4pKVii_NCp9-xJmiwyipL-HCrWd_Affs",
        authDomain: "peacockandquill.firebaseapp.com",
        databaseURL: "https://peacockandquill.firebaseio.com",
        projectId: "peacockandquill",
        storageBucket: "peacockandquill.appspot.com",
        messagingSenderId: "768283907591",
        appId: "1:768283907591:web:b4090e0071f4bfa9563ca2",
        measurementId: "G-3E7DSL719Y",
        name: "PeacockAndQuill",
      );
    }
  }

  void updateUser(AuthResult authResult) async {
    if (authResult != null) {
      final fbUser = await authResult.user;
      final store = firestore();
      final doc = store.collection('users').doc(fbUser.uid);

      final user = m.User(
        uid: fbUser.uid,
        name: fbUser.displayName,
        email: fbUser.email,
        isAnonymous: fbUser.isAnonymous,
        createdAt: DateTime.now(),
      );

      doc.set(user.toJson());
    }
  }
}
