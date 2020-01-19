import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';

abstract class IContentRepository {
  final String collectionName = "content";
  final String presenterId = "jn8HsjD1vROpepjAD8vK7YAgtl93";

  Stream<Iterable<IContentEntity>> getContent();
}
