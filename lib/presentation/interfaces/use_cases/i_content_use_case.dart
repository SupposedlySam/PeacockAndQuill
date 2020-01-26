import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';

abstract class IContentUseCase {
  Stream<List<IContentEntity>> getContent();
}
