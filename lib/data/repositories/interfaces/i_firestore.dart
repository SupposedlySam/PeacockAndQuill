import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirestore {
  void init();
  void updateUser(AuthResult user);
}
