import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/question_model.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_question_entity.dart';
import 'package:peacock_and_quill/domain/entities/question_entity.dart';

class QuestionRepository extends IQuestionRepository {
  @override
  void addQuestion(String uid, int slide, int paragraph) async {
    final store = fs.Firestore.instance;
    final ref = await store.collection(collectionName).reference();

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
    final store = fs.Firestore.instance;
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", isEqualTo: presenterId)
        .getDocuments();

    final docEntities = _docsToEntity(snapshots.documents);

    return docEntities;
  }

  @override
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide) async {
    final store = fs.Firestore.instance;
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", isEqualTo: presenterId)
        .where("selection.slide", isEqualTo: slide)
        .getDocuments();

    final docEntities = _docsToEntity(snapshots.documents);

    return docEntities;
  }

  @override
  Stream<List<IQuestionEntity>> getQuestionsByUser(String uid) {
    final store = fs.Firestore.instance;
    final snapshots = store
        .collection(collectionName)
        .where("presentationId", isEqualTo: presenterId)
        .where("uid", isEqualTo: uid)
        .snapshots();

    final docEntities = snapshots.map((snap) => _docsToEntity(snap.documents));

    return docEntities;
  }

  @override
  void removeQuestion(String uid, int screen, int paragraph) async {
    final store = fs.Firestore.instance;
    final snapshots = await store
        .collection(collectionName)
        .where("uid", isEqualTo: uid)
        .where("presentationId", isEqualTo: presenterId)
        .where("selection.paragraph", isEqualTo: paragraph)
        .where("selection.slide", isEqualTo: screen)
        .getDocuments();

    if (snapshots.documents.isNotEmpty) {
      await snapshots.documents.first.reference.delete();
    }
  }

  List<QuestionEntity> _docsToEntity(List<fs.DocumentSnapshot> documents) {
    final docModels = documents.map((doc) {
      return QuestionModel.fromJson(doc.data);
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
