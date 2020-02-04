import 'package:firebase/firebase.dart';
import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:peacock_and_quill/domain/interfaces/web/i_web_only_presentation_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

class WebOnlyPresentationRepository extends BaseRepositoryWeb
    implements IWebOnlyPresentationRepository {
  final String collectionName = 'presentations';

  @override
  Future<List<IPresentationEntity>> getPresentations() async {
    final user = await getUserDetail();
    final store = firestore();
    // Get the current users's presentations
    final snapshots = await store
        .collection(collectionName)
        .where("uid", "==", user.uid)
        .get();

    final models = snapshots.docs.map<PresentationModel>(
      (snap) => PresentationModel.fromJson(snap.data()
        ..addAll({
          'refId': snap.id,
        })),
    );

    return models
        .map(
          (model) => PresentationEntity(
            code: model.code,
            currentSlide: model.currentSlide,
            initialSlide: model.initialSlide,
            isActive: model.isActive,
            title: model?.title,
            refId: model.refId,
          ),
        )
        .toList();
  }
}
