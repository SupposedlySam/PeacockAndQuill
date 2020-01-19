import 'package:firebase/firebase.dart';
import 'package:peacock_and_quill/data/models/firebase/content_model.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/content_entity.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';

class ContentRepository extends IContentRepository {
  @override
  Stream<Iterable<IContentEntity>> getContent() {
    final store = firestore();
    final snapshots = store
        .collection(collectionName)
        .where("presentationId", "==", presenterId)
        .onSnapshot;

    final docModels = snapshots.map(
      (snap) => snap.docs.map(
        (doc) => ContentModel.fromJson(
          doc.data(),
        ),
      ),
    );

    final docEntities = docModels.map(
      (models) => models.map(
        (model) {
          return ContentEntity(
            data: model.data,
            order: model.order,
            presentationId: model.presentationId,
            uid: model.uid,
          );
        },
      ),
    );

    return docEntities;
  }
}