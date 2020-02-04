import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/question_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/base_repository_mobile.dart';
import 'package:peacock_and_quill/domain/entities/question_entity.dart';
import 'package:peacock_and_quill/domain/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:rxdart/rxdart.dart';

class QuestionRepository extends BaseRepositoryMobile
    implements IQuestionRepository {
  final String collectionName = "questions";

  @override
  Future<void> addQuestion(String uid, int slide, int paragraph) async {
    final store = fs.Firestore.instance;
    final ref = await store.collection(collectionName).reference();
    final user = await getUserDetail();

    final userQuestion = QuestionModel(
      refId: '',
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
    final store = fs.Firestore.instance;
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", isEqualTo: user.activePresentation)
        .getDocuments();

    final docEntities = _docsToEntity(snapshots.documents);

    return docEntities;
  }

  @override
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide) async {
    final user = await getUserDetail();
    final store = fs.Firestore.instance;
    final snapshots = await store
        .collection(collectionName)
        .where("presentationId", isEqualTo: user.activePresentation)
        .where("selection.slide", isEqualTo: slide)
        .getDocuments();

    final docEntities = _docsToEntity(snapshots.documents);

    return docEntities;
  }

  @override
  Stream<List<IQuestionEntity>> getQuestionsByUser() {
    final user = getUserDetail().asStream();
    final snapshots = user.switchMap((user) => fs.Firestore.instance
        .collection(collectionName)
        .where("presentationId", isEqualTo: user.activePresentation)
        .where("uid", isEqualTo: user.uid)
        .snapshots());

    final docEntities = snapshots.map((snap) => _docsToEntity(snap.documents));

    return docEntities;
  }

  @override
  Future<bool> hasQuestion(int pageIndex, int paragraphIndex) async {
    final user = await getUserDetail();
    final questions = await fs.Firestore.instance
        .collection(collectionName)
        .where("presentationId", isEqualTo: user.activePresentation)
        .where("uid", isEqualTo: user.uid)
        .where("selection.slide", isEqualTo: pageIndex)
        .where("selection.paragraph", isEqualTo: paragraphIndex)
        .getDocuments();

    final questionAmount = questions.documents.length;
    return questionAmount > 0;
  }

  @override
  Future<void> removeQuestion(int screen, int paragraph) async {
    final user = await getUserDetail();
    final store = fs.Firestore.instance;
    final snapshots = await store
        .collection(collectionName)
        .where("uid", isEqualTo: user.uid)
        .where("presentationId", isEqualTo: user.activePresentation)
        .where("selection.paragraph", isEqualTo: paragraph)
        .where("selection.slide", isEqualTo: screen)
        .getDocuments();

    if (snapshots.documents.isNotEmpty) {
      await snapshots.documents.first.reference.delete();
    }
  }

  @override
  Future<void> removeQuestionById(String refId) async {
    final question =
        await fs.Firestore.instance.collection(collectionName).document(refId);
    await question.delete();
  }

  List<QuestionEntity> _docsToEntity(List<fs.DocumentSnapshot> documents) {
    final docModels = documents.map((doc) {
      return QuestionModel.fromJson(
        doc.data
          ..addAll({
            'refId': doc.documentID,
          }),
      );
    });

    final docEntities = docModels.map(
      (model) {
        return QuestionEntity(
          refId: model.refId,
          selection: model.selection,
          presentationId: model.presentationId,
          uid: model.uid,
        );
      },
    ).toList();
    return docEntities;
  }
}
