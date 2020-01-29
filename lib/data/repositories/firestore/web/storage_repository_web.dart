import 'package:firebase/firebase.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';

class StorageRepository implements IStorageRepository {
  @override
  Future<String> loadImage(String image) async {
    var url = await storage()
        .ref('jn8HsjD1vROpepjAD8vK7YAgtl93/$image')
        .getDownloadURL();
    return url?.toString() ?? '';
  }
}
