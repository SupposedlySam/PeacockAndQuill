import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:peacock_and_quill/data/models/firebase/question_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/entities/question_entity.dart';
import 'package:peacock_and_quill/domain/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:rxdart/rxdart.dart';

class QuestionRepository extends BaseRepositoryWeb
    implements IQuestionRepository {
  final String collectionName = "questions";

  @override
  void addQuestion(String uid, int slide, int paragraph) async {
    final user = await getUserDetail();
    final store = firestore();
    final ref = await store.collection(collectionName);

    final userQuestion = QuestionModel(
      presentationId: user.activePresentation,
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
    final user = await getUserDetail();
    final store = firestore();
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", "==", user.activePresentation)
        .get();

    final docEntities = _docsToEntity(snapshots.docs);

    return docEntities;
  }

  @override
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide) async {
    final user = await getUserDetail();
    final store = firestore();
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", "==", user.activePresentation)
        .where("selection.slide", "==", slide)
        .get();

    final docEntities = _docsToEntity(snapshots.docs);

    return docEntities;
  }

  @override
  Stream<List<IQuestionEntity>> getQuestionsByUser() {
    final user = getUserDetailStream();
    final snapshots = user.switchMap((user) => firestore()
        .collection(collectionName)
        .where("presentationId", "==", user.activePresentation)
        .where("uid", "==", user.uid)
        .onSnapshot);

    final docEntities = snapshots.map((snap) => _docsToEntity(snap.docs));

    return docEntities;
  }

  @override
  Future<bool> hasQuestion(int pageIndex, int paragraphIndex) async {
    final user = await getUserDetail();
    final questions = await firestore()
        .collection(collectionName)
        .where("presentationId", "==", user.activePresentation)
        .where("uid", "==", user.uid)
        .where("selection.slide", "==", pageIndex)
        .where("selection.paragraph", "==", paragraphIndex)
        .get();

    final questionAmount = questions.docs.length;
    return questionAmount > 0;
  }

  @override
  void removeQuestion(int screen, int paragraph) async {
    final user = await getUserDetail();
    final store = firestore();
    final snapshots = await store
        .collection(collectionName)
        .where("uid", "==", user.uid)
        .where("presentationId", "==", user.activePresentation)
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
