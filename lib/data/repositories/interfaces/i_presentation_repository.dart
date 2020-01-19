import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';

abstract class IPresentationRepository {
  final String collectionName = "presentations";
  final String presenterId = "jn8HsjD1vROpepjAD8vK7YAgtl93";

  Future<int> getInitialSlide();
  Stream<PresentationEntity> getPresentationStream();
  void updateSlide(int slideIndex);
}
