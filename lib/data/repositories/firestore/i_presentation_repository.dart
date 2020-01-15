import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';

abstract class IPresentationRepository {
  final String collectionName = "presentations";
  final String presenterId = "jn8HsjD1vROpepjAD8vK7YAgtl93";

  Stream<PresentationEntity> getPresentation();
  void updateSlide(PresentationEntity presentationEntity);
}
