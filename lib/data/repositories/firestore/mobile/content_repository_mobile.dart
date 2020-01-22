import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/content_model.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';

class ContentRepository extends IContentRepository {
  @override
  Stream<List<IContentEntity>> getContent() {
    final store = fs.Firestore.instance;
    final snapshots = store
        .collection(collectionName)
        .where("presentationId", isEqualTo: presenterId)
        .snapshots();

    final docModels = snapshots.map(
      (snap) {
        final documents = snap.documents;

        return documents.map(docToContentModel);
      },
    );

    final docEntities = docModels.map(
      (models) {
        return models.map(
          (model) {
            return ContentEntity(
              data: model.data,
              order: model.order,
              presentationId: model.presentationId,
              uid: model.uid,
            );
          },
        ).toList();
      },
    );

    return docEntities;
  }

  ContentModel docToContentModel(doc) {
    return ContentModel.fromJson(doc.data);
  }
}
