import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/presentation/views/base_view.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_desktop.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_mobile.dart';

class HomeView extends StatelessWidget {
  final IContentRepository contentRepository;
  final IStorageRepository storageRepository;

  const HomeView(
      {@required this.contentRepository, @required this.storageRepository});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      storageRepository: storageRepository,
      child: (kIsWeb)
          ? HomeContentDesktop(contentRepository: contentRepository)
          : HomeContentMobile(contentRepository: contentRepository),
    );
  }
}
