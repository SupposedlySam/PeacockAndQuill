import 'package:rxdart/rxdart.dart';
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

  Stream<UserModel> getUserDetailStream() {
    final user = FirebaseAuth.instance.currentUser().asStream();
    final doc = user.switchMap((user) => fs.Firestore.instance
        .collection('users')
        .document(user.uid)
        .snapshots());

    return doc.map((doc) => UserModel.fromJson(doc.data));
  }
}
