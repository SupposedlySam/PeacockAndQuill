import 'package:firebase/firestore.dart';
import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:firebase/firebase.dart';

class PresentationRepository extends IPresentationRepository {
  @override
  Stream<PresentationEntity> getPresentationStream() {
    final store = firestore();
    final doc = store.collection(collectionName).doc(presenterId);
    final models = doc.onSnapshot.map<PresentationModel>(
      (snap) => PresentationModel.fromJson(snap.data()),
    );

    return models.map(
      (model) => PresentationEntity(
        currentSlide: model.currentSlide,
        initialSlide: model.initialSlide,
      ),
    );
  }

  @override
  void updateSlide(int slideIndex) {
    final store = firestore();
    final doc = store.collection(collectionName).doc(presenterId);
    final model = PresentationModel(
      currentSlide: slideIndex,
    );

    doc.set(model.toJson(), SetOptions(merge: true));
  }

  @override
  Future<int> getInitialSlide() async {
    final store = firestore();
    final doc = await store.collection(collectionName).doc(presenterId).get();
    final model = PresentationModel.fromJson(doc.data());

    return model.initialSlide;
  }

  @override
  Future<int> getCurrentSlide() async {
    final store = firestore();
    final doc = await store.collection(collectionName).doc(presenterId).get();
    final model = PresentationModel.fromJson(doc.data());

    return model.currentSlide;
  }
}
