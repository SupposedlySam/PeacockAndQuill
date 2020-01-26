import 'package:firebase/firebase.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/base_repository_web.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';

class StorageRepository extends BaseRepositoryWeb
    implements IStorageRepository {
  final String collectionName = "content";

  @override
  Future<String> loadImage(String image) async {
    final user = await getUserDetail();
    var url = await storage()
        .ref('${user.activePresentation}/$image')
        .getDownloadURL();
    return url?.toString() ?? '';
  }
}
