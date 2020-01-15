import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import 'i_presentation_repository.dart';

class PresentationRepository extends IPresentationRepository {
  @override
  Stream<PresentationEntity> getPresentation() {
    final store = fs.Firestore.instance;
    final doc = store.collection(collectionName).document(presenterId);
    final models = doc.snapshots().map<PresentationModel>(
      (snap) {
        return PresentationModel.fromJson(snap.data);
      },
    );

    return models.map(
      (model) {
        print(model.currentSlide);
        return PresentationEntity(
          currentSlide: model.currentSlide,
        );
      },
    );
  }

  @override
  void updateSlide(PresentationEntity presentationEntity) {
    // TODO: implement updateSlide
  }
}
