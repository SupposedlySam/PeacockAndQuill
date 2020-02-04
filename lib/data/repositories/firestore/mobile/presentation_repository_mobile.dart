import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/base_repository_mobile.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';

class PresentationRepository extends BaseRepositoryMobile
    implements IPresentationRepository {
  final String collectionName = "presentations";

  @override
  Stream<PresentationEntity> getPresentationStream() {
    final user = getUserDetailStream();
    final doc = user.switchMap((user) => fs.Firestore.instance
        .collection(collectionName)
        .document(user.activePresentation)
        .snapshots());
    final models = doc.map<PresentationModel>(
      (snap) => PresentationModel.fromJson(snap.data
        ..addAll({
          'refId': snap.documentID,
        })),
    );

    return models.map(
      (model) => PresentationEntity(
        code: model?.code,
        currentSlide: model?.currentSlide ?? 0,
        initialSlide: model?.initialSlide ?? 0,
        isActive: model?.isActive ?? false,
        title: model?.title,
        refId: model.refId,
      ),
    );
  }

  @override
  Future<void> updateSlide(int slideIndex) async {}

  @override
  Future<int> getInitialSlide() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data
      ..addAll({
        'refId': doc.documentID,
      }));

    return model.initialSlide;
  }

  @override
  Future<int> getCurrentSlide() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data
      ..addAll({
        'refId': doc.documentID,
      }));

    return model.currentSlide;
  }

  @override
  Future<bool> checkPresentationExists(String presentationCode) {
    return fs.Firestore.instance
        .collection(collectionName)
        .where('code', isEqualTo: presentationCode)
        .getDocuments()
        .then((snap) => snap.documents.length > 0);
  }

  @override
  Future<String> getPresentationIdFromCode(String presentationCode) async {
    final doc = await fs.Firestore.instance
        .collection(collectionName)
        .where('code', isEqualTo: presentationCode)
        .getDocuments()
        .then((snap) => snap.documents.first);

    return doc.documentID;
  }

  @override
  Future<bool> toggleActive() async {
    final doc = await _getCurrentPresentation();
    final currentVal = doc.data['isActive'];
    final nextVal = !currentVal;
    await doc.reference.setData({'isActive': nextVal}, merge: true);
    return nextVal;
  }

  @override
  Future<PresentationEntity> getActivePresentation() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data);

    return PresentationEntity(
      code: model.code,
      refId: doc.documentID,
      title: model.title,
      currentSlide: model.currentSlide,
      initialSlide: model.initialSlide,
      isActive: model.isActive,
    );
  }

  Future<fs.DocumentSnapshot> _getCurrentPresentation() async {
    final user = await getUserDetail();
    return fs.Firestore.instance
        .collection(collectionName)
        .document(user.activePresentation)
        .get();
  }
}
