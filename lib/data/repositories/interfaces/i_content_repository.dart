import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';

abstract class IContentRepository {
  final String collectionName = "content";
  final String presenterId = "jn8HsjD1vROpepjAD8vK7YAgtl93";

  Stream<List<IContentEntity>> getContent();
}
