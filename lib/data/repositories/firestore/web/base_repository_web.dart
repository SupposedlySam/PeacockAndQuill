import 'package:rxdart/rxdart.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';

class BaseRepositoryWeb {
  Future<UserModel> getUserDetail() async {
    final user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      final doc =
          await firestore().collection('users').doc(user?.uid ?? '').get();

      return UserModel.fromJson(doc.data());
    }
    return null;
  }

  Stream<UserModel> getUserDetailStream() {
    final user = FirebaseAuth.instance.currentUser().asStream();
    final doc = user.switchMap(
      (user) => firestore().collection('users').doc(user.uid).onSnapshot,
    );

    return doc.map((doc) => UserModel.fromJson(doc.data()));
  }
}
