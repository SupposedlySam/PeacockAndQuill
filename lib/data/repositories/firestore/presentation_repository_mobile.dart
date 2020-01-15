import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import 'i_presentation_repository.dart';

class PresentationRepository extends IPresentationRepository {
  @override
  Stream<PresentationEntity> getPresentationStream() {
    final store = fs.Firestore.instance;
    store.document('$collectionName/$presenterId').get();
    final doc = store.collection(collectionName).document(presenterId);

    return doc
        .snapshots()
        .map<PresentationModel>((snap) => PresentationModel.fromJson(snap.data))
        .map(
          (model) => PresentationEntity(
            currentSlide: model.currentSlide,
            initialSlide: model.initialSlide,
          ),
        );
  }

  @override
  void updateSlide(int slideIndex) {}

  @override
  Future<int> getInitialSlide() async {
    final store = fs.Firestore.instance;
    final doc =
        await store.collection(collectionName).document(presenterId).get();
    final model = PresentationModel.fromJson(doc.data);

    return model.initialSlide;
  }
}
