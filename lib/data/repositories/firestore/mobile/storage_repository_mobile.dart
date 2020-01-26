import 'package:firebase_storage/firebase_storage.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';

class StorageRepository extends IStorageRepository {
  @override
  Future<String> loadImage(String image) async {
    final url = await FirebaseStorage.instance
        .ref()
        .child('$presenterId/$image')
        .getDownloadURL();
    return url;
  }
}
