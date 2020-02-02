import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/base_repository_mobile.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';

class UserRepository extends BaseRepositoryMobile implements IUserRepository {
  final String collectionName = "users";
  final fs.Firestore _firestore = fs.Firestore.instance;

  Future<void> updateUser(AuthResult authResult) async {
    if (authResult != null) {
      final fbUser = await authResult.user;
      final doc = _firestore.collection(collectionName).document(fbUser.uid);

      final user = UserModel(
        uid: fbUser.uid,
        name: fbUser.displayName,
        email: fbUser.email,
        isAnonymous: fbUser.isAnonymous,
        createdAt: DateTime.now(),
      );

      doc.setData(user.toJson(), merge: true);
    }
  }

  @override
  Future<void> setActivePresentation(String presentationId) async {
    final user = await FirebaseAuth.instance.currentUser();

    if (user != null) {
      final doc =
          fs.Firestore.instance.collection(collectionName).document(user.uid);

      doc.setData({'activePresentation': presentationId}, merge: true);
    }
  }
}
