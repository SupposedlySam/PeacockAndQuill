import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';

class UserRepository extends BaseRepositoryWeb implements IUserRepository {
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

      final user = UserModel(
        uid: fbUser.uid,
        name: fbUser.displayName,
        email: fbUser.email,
        isAnonymous: fbUser.isAnonymous,
        createdAt: DateTime.now(),
      );

      doc.set(user.toJson(), SetOptions(merge: true));
    }
  }

  @override
  void setActivePresentation(String presentationId) async {
    final user = await FirebaseAuth.instance.currentUser();
    final doc = firestore().collection('users').doc(user.uid);

    doc.set({'activePresentation': presentationId}, SetOptions(merge: true));
  }
}
