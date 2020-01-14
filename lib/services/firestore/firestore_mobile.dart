import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/interfaces/i_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/models/firebase/user.dart';

class Firestore implements IFirestore {
  final fs.Firestore _firestore = fs.Firestore.instance;
  void init() {}

  void updateUser(AuthResult authResult) async {
    if (authResult != null) {
      final fbUser = await authResult.user;
      final doc = _firestore.collection('users').document(fbUser.uid);

      final user = User(
        uid: fbUser.uid,
        name: fbUser.displayName,
        email: fbUser.email,
        isAnonymous: fbUser.isAnonymous,
        createdAt: DateTime.now(),
      );

      doc.setData(user.toJson());
    }
  }
}
