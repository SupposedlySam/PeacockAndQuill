import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peacock_and_quill/data/models/firebase/user_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/entities/question_user_entity.dart';
import 'package:peacock_and_quill/domain/entities/user_entity.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_user_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_user_entity.dart';

class UserRepository extends BaseRepositoryWeb implements IUserRepository {
  final String collectionName = "users";

  Future<void> updateUser(FirebaseUser currentUser) async {
    if (currentUser != null) {
      final fbUser = await currentUser;
      final store = firestore();
      final doc = store.collection(collectionName).doc(fbUser.uid);

      final user = UserModel(
        uid: fbUser.uid,
        name: fbUser.displayName,
        email: fbUser.email,
        isAnonymous: fbUser.isAnonymous,
        createdAt: DateTime.now(),
      );

      doc.set(user.toJson(), SetOptions(merge: true));
    }
  }

  @override
  Future<void> setActivePresentation(String presentationId) async {
    final user = await getUserDetail();

    if (user != null) {
      final doc = firestore().collection(collectionName).doc(user.uid);

      doc.set({'activePresentation': presentationId}, SetOptions(merge: true));
    }
  }

  @override
  Future<IUserEntity> getUser(String uid) async {
    final doc = await firestore().collection(collectionName).doc(uid).get();
    final model = UserModel.fromJson(doc.data());
    return UserEntity(
      uid: doc.id,
      activePresentation: model.activePresentation,
      name: model.name,
    );
  }

  Stream<IUserEntity> getUserStream(String uid) {
    final doc = firestore().collection(collectionName).doc(uid).onSnapshot;
    final model = doc.map((snap) => UserModel.fromJson(snap.data()));
    return model.map(
      (user) => UserEntity(
        uid: user.uid,
        activePresentation: user.activePresentation,
        name: user.name,
      ),
    );
  }

  @override
  List<Future<IQuestionUserEntity>> getUsersFromQuestions(
      List<IQuestionEntity> questions) {
    return questions
        .map(
          (question) => getUser(question.uid).then(
            (user) => QuestionUserEntity(
              name: user.name,
              presentationId: question.presentationId,
              questionRef: question.refId,
              selection: question.selection,
              uid: user.uid,
            ),
          ),
        )
        .toList();
  }
}
