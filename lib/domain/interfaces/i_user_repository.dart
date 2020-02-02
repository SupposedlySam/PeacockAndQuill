import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRepository {
  final String collectionName = 'users';
  Future<void> updateUser(AuthResult user);
  Future<void> setActivePresentation(String presentationId);
}
