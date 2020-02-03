import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

abstract class IWebOnlyPresentationUseCase {
  Future<List<IPresentationEntity>> getPresentations();
}
