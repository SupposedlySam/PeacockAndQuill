import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/content_model.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/content_entity.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';

class ContentRepository extends IContentRepository {
  @override
  Stream<Iterable<IContentEntity>> getContent() {
    final store = fs.Firestore.instance;
    final snapshots = store
        .collection(collectionName)
        .where("presentationId", isEqualTo: presenterId)
        .snapshots();

    final docModels = snapshots.map<Iterable<ContentModel>>(
      (snap) {
        return snap.documents.map<ContentModel>(
          (doc) {
            return ContentModel.fromJson(doc.data);
          },
        );
      },
    );

    final docEntities = docModels.map<Iterable<ContentEntity>>(
      (models) {
        return models.map<ContentEntity>(
          (model) {
            return ContentEntity(
              data: model.data,
              order: model.order,
              presentationId: model.presentationId,
              uid: model.uid,
            );
          },
        );
      },
    );

    return docEntities;
  }
}
