import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRepository {
  final String collectionName = 'users';
  void updateUser(AuthResult user);
  void setActivePresentation(String presentationId);
}
