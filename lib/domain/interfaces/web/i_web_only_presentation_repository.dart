import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

abstract class IWebOnlyPresentationRepository {
  Future<List<IPresentationEntity>> getPresentations();
}
