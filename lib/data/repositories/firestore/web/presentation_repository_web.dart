import 'package:rxdart/rxdart.dart';
import 'package:firebase/firestore.dart';
import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:firebase/firebase.dart';

class PresentationRepository extends BaseRepositoryWeb
    implements IPresentationRepository {
  final String collectionName = "presentations";

  @override
  Stream<PresentationEntity> getPresentationStream() {
    final user = getUserDetailStream();
    final doc = user.switchMap((user) => firestore()
        .collection(collectionName)
        .doc(user.activePresentation)
        .onSnapshot);
    final models = doc.map<PresentationModel>(
      (snap) => PresentationModel.fromJson(snap.data()
        ..addAll({
          'refId': snap.id,
        })),
    );

    return models.map(
      (model) => PresentationEntity(
        currentSlide: model.currentSlide,
        initialSlide: model.initialSlide,
        isActive: model.isActive,
        title: model?.title,
        refId: model.refId,
      ),
    );
  }

  @override
  void updateSlide(int slideIndex) async {
    final doc = await _getCurrentPresentation();

    doc.ref.set({'currentSlide': slideIndex}, SetOptions(merge: true));
  }

  @override
  Future<int> getInitialSlide() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data()
      ..addAll({
        'refId': doc.id,
      }));

    return model.initialSlide;
  }

  @override
  Future<int> getCurrentSlide() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data()
      ..addAll({
        'refId': doc.id,
      }));

    return model.currentSlide;
  }

  @override
  Future<bool> checkPresentationExists(String presentationCode) {
    return firestore()
        .collection(collectionName)
        .where('code', '==', presentationCode)
        .get()
        .then((snap) => snap.docs.length > 0);
  }

  @override
  Future<String> getPresentationIdFromCode(String presentationCode) async {
    final doc = await firestore()
        .collection(collectionName)
        .where('code', '==', presentationCode)
        .get()
        .then((snap) => snap.docs.first);

    return doc.id;
  }

  @override
  void toggleActive() async {
    final doc = await _getCurrentPresentation();
    final bool currentVal = doc.data()['isActive'];

    doc.ref.set({'isActive': !currentVal}, SetOptions(merge: true));
  }

  Future<DocumentSnapshot> _getCurrentPresentation() async {
    final user = await getUserDetail();
    return firestore()
        .collection(collectionName)
        .doc(user.activePresentation)
        .get();
  }
}
