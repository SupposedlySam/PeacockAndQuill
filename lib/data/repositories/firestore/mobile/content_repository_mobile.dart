import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/content_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/base_repository_mobile.dart';
import 'package:peacock_and_quill/domain/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';

class ContentRepository extends BaseRepositoryMobile
    implements IContentRepository {
  final String collectionName = "content";

  @override
  Stream<List<IContentEntity>> getContent() {
    final user = getUserDetail().asStream();
    final snapshots = user.switchMap((user) => fs.Firestore.instance
        .collection(collectionName)
        .where("presentationId", isEqualTo: user.activePresentation)
        .snapshots());

    final docModels = snapshots.map(
      (snap) => snap.documents.map(
        (doc) => ContentModel.fromJson(
          doc.data,
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
      ).toList(),
    );

    return docEntities;
  }
}
