import 'package:firebase_storage/firebase_storage.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/base_repository_mobile.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';

class StorageRepository extends BaseRepositoryMobile
    implements IStorageRepository {
  final String collectionName = "content";

  @override
  Future<String> loadImage(String image) async {
    final url = await FirebaseStorage.instance
        .ref()
        .child('jn8HsjD1vROpepjAD8vK7YAgtl93/$image')
        .getDownloadURL();
    return url;
  }
}
