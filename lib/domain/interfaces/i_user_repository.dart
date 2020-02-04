import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_user_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_user_entity.dart';

abstract class IUserRepository {
  final String collectionName = 'users';
  Future<void> updateUser(FirebaseUser user);
  Future<void> setActivePresentation(String presentationId);
  Future<IUserEntity> getUser(String uid);
  Stream<IUserEntity> getUserStream(String uid);
  List<Future<IQuestionUserEntity>> getUsersFromQuestions(
      List<IQuestionEntity> questions);
}
