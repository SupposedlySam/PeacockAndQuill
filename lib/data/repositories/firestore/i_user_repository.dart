import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRepository {
  void init();
  void updateUser(AuthResult user);
}
