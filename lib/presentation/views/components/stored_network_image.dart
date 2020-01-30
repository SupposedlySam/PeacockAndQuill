import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class StoredNetworkImage extends StatelessWidget {
  final IStorageRepository storageRepository;
  final String url;
  const StoredNetworkImage({
    @required this.url,
    @required this.storageRepository,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
      create: (_) => storageRepository.loadImage(url),
      child: Consumer<String>(
        builder: (_, url, __) {
          if (url != null) {
            final image = Image.network(
              url,
            );
            return GestureDetector(
              child: image,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(),
                    body: PhotoView(
                      imageProvider: image.image,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return loading();
          }
        },
      ),
    );
  }

  Widget loading() {
    return LimitedBox(
      maxHeight: 40,
      child: AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
