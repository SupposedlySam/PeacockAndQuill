import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';

abstract class IPresentationRepository {
  final String collectionName = "presentations";

  Future<int> getInitialSlide();
  Future<int> getCurrentSlide();
  Future<bool> checkPresentationExists(String presentationCode);
  Future<String> getPresentationIdFromCode(String presentationCode);

  Stream<PresentationEntity> getPresentationStream();

  void updateSlide(int slideIndex);
  void toggleActive();
}
