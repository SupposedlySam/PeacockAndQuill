import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:peacock_and_quill/data/models/firebase/question_model.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/domain/entities/question_entity.dart';

class QuestionRepository extends IQuestionRepository {
  @override
  void addQuestion(String uid, int slide, int paragraph) async {
    final store = firestore();
    final ref = await store.collection(collectionName);

    final userQuestion = QuestionModel(
      presentationId: presenterId,
      uid: uid,
      selection: SelectionModel(
        paragraph: paragraph,
        slide: slide,
      ),
    );

    ref.add(userQuestion.toJson());
  }

  @override
  Future<List<IQuestionEntity>> getAllQuestions() async {
    final store = firestore();
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", "==", presenterId)
        .get();

    final docEntities = _docsToEntity(snapshots.docs);

    return docEntities;
  }

  @override
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide) async {
    final store = firestore();
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", "==", presenterId)
        .where("selection.slide", "==", slide)
        .get();

    final docEntities = _docsToEntity(snapshots.docs);

    return docEntities;
  }

  @override
  Stream<List<IQuestionEntity>> getQuestionsByUser(String uid) {
    final store = firestore();
    final snapshots = store
        .collection(collectionName)
        .where("presentationId", "==", presenterId)
        .where("uid", "==", uid)
        .onSnapshot;

    final docEntities = snapshots.map((snap) => _docsToEntity(snap.docs));

    return docEntities;
  }

  @override
  void removeQuestion(String uid, int screen, int paragraph) async {
    final store = firestore();
    final snapshots = await store
        .collection(collectionName)
        .where("uid", "==", uid)
        .where("presentationId", "==", presenterId)
        .where("selection.paragraph", "==", paragraph)
        .where("selection.slide", "==", screen)
        .get();

    snapshots.docs.first.ref.delete();
  }

  List<QuestionEntity> _docsToEntity(List<DocumentSnapshot> documents) {
    final docModels = documents.map((doc) {
      return QuestionModel.fromJson(doc.data());
    });

    final docEntities = docModels.map(
      (model) {
        return QuestionEntity(
          selection: model.selection,
          presentationId: model.presentationId,
          uid: model.uid,
        );
      },
    ).toList();
    return docEntities;
  }
}
