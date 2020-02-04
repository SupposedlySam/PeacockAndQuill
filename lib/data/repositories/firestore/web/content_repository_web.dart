import 'package:rxdart/rxdart.dart';
import 'package:firebase/firebase.dart';
import 'package:peacock_and_quill/data/models/firebase/content_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';

class ContentRepository extends BaseRepositoryWeb
    implements IContentRepository {
  final String collectionName = "content";

  @override
  Stream<List<IContentEntity>> getContent() {
    final user = getUserDetailStream();
    final snapshots = user.switchMap((user) => firestore()
        .collection(collectionName)
        .where("presentationId", "==", user.activePresentation)
        .orderBy("order")
        .onSnapshot);

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
      ).toList(),
    );

    return docEntities;
  }
}
