abstract class IStorageRepository {
  final String collectionName = "content";
  final String presenterId = "jn8HsjD1vROpepjAD8vK7YAgtl93";

  Future<String> loadImage(String image);
}
