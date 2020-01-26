import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';

class BaseRepositoryMobile {
  Future<UserModel> getUserDetail() async {
    final user = await FirebaseAuth.instance.currentUser();
    final doc = await fs.Firestore.instance
        .collection('users')
        .document(user.uid)
        .get();

    return UserModel.fromJson(doc.data);
  }
}
