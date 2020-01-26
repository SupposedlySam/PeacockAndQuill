import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';

abstract class IContentRepository {
  final String collectionName = "content";

  Stream<List<IContentEntity>> getContent();
}
