import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:firebase/firebase.dart';

class PresentationRepository extends IPresentationRepository {
  @override
  Stream<PresentationEntity> getPresentation() {
    final store = firestore();
    final doc = store.collection(collectionName).doc(presenterId);
    final models = doc.onSnapshot.map<PresentationModel>(
      (snap) => PresentationModel.fromJson(snap.data()),
    );

    return models.map(
      (model) => PresentationEntity(
        currentSlide: model.currentSlide,
      ),
    );
  }

  @override
  void updateSlide(PresentationEntity presentationEntity) {
    // TODO: implement updateSlide
  }
}
