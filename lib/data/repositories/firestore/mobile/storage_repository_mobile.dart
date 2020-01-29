import 'package:firebase_storage/firebase_storage.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';

class StorageRepository implements IStorageRepository {
  @override
  Future<String> loadImage(String image) async {
    final url = await FirebaseStorage.instance
        .ref()
        .child('jn8HsjD1vROpepjAD8vK7YAgtl93/$image')
        .getDownloadURL();
    return url;
  }
}
