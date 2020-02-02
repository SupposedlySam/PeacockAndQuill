import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';

class UserRepository extends BaseRepositoryWeb implements IUserRepository {
  final String collectionName = "users";

  Future<void> updateUser(AuthResult authResult) async {
    if (authResult != null) {
      final fbUser = await authResult.user;
      final store = firestore();
      final doc = store.collection(collectionName).doc(fbUser.uid);

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
  Future<void> setActivePresentation(String presentationId) async {
    final user = await FirebaseAuth.instance.currentUser();

    if (user != null) {
      final doc = firestore().collection(collectionName).doc(user.uid);

      doc.set({'activePresentation': presentationId}, SetOptions(merge: true));
    }
  }
}
