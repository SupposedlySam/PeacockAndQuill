import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:peacock_and_quill/data/models/firebase/presentation_model.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/base_repository_mobile.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';

class PresentationRepository extends BaseRepositoryMobile
    implements IPresentationRepository {
  final String collectionName = "presentations";

  @override
  Stream<PresentationEntity> getPresentationStream() {
    final doc = _getCurrentPresentation().asStream();
    final models = doc.map<PresentationModel>(
      (snap) => PresentationModel.fromJson(snap.data),
    );

    return models.map(
      (model) => PresentationEntity(
        currentSlide: model.currentSlide,
        initialSlide: model.initialSlide,
        isActive: model.isActive,
      ),
    );
  }

  @override
  void updateSlide(int slideIndex) {}

  @override
  Future<int> getInitialSlide() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data);

    return model.initialSlide;
  }

  @override
  Future<int> getCurrentSlide() async {
    final doc = await _getCurrentPresentation();
    final model = PresentationModel.fromJson(doc.data);

    return model.currentSlide;
  }

  @override
  Future<bool> checkPresentationExists(String presentationCode) {
    return fs.Firestore.instance
        .collection(collectionName)
        .where('code', isEqualTo: presentationCode)
        .getDocuments()
        .then((snap) => snap.documents.length > 0);
  }

  @override
  Future<String> getPresentationIdFromCode(String presentationCode) async {
    final doc = await fs.Firestore.instance
        .collection(collectionName)
        .where('code', isEqualTo: presentationCode)
        .getDocuments()
        .then((snap) => snap.documents.first);

    return doc.documentID;
  }

  @override
  void toggleActive() async {
    final doc = await _getCurrentPresentation();
    final currentVal = doc.data['isActive'];

    doc.reference.setData({'isActive': !currentVal}, merge: true);
  }

  Future<fs.DocumentSnapshot> _getCurrentPresentation() async {
    final user = await getUserDetail();
    return fs.Firestore.instance
        .collection(collectionName)
        .document(user.activePresentation)
        .get();
  }
}
