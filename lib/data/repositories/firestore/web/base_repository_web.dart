import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';

class BaseRepositoryWeb {
  Future<UserModel> getUserDetail() async {
    final user = await FirebaseAuth.instance.currentUser();
    final doc = await firestore().collection('users').doc(user.uid).get();

    return UserModel.fromJson(doc.data());
  }
}
