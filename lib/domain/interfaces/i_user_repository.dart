import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRepository {
  final String collectionName = 'users';
  Future<void> updateUser(FirebaseUser user);
  Future<void> setActivePresentation(String presentationId);
}
