abstract class IStorageRepository {
  final String collectionName = "content";

  Future<String> loadImage(String image);
}
