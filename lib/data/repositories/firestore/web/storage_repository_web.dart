import 'package:firebase/firebase.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';

class StorageRepository extends IStorageRepository {
  @override
  Future<String> loadImage(String image) async {
    var url = await storage().ref('$presenterId/$image').getDownloadURL();
    return url?.toString() ?? '';
  }
}
