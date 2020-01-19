import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:peacock_and_quill/presentation/views/base_view.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_desktop.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_mobile.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final IContentRepository contentRepository;

  const HomeView({@required this.contentRepository});

  @override
  Widget build(BuildContext context) {
    final model = locator<PresenterViewModel>();

    return StreamProvider<List<IContentEntity>>.value(
      value: contentRepository.getContent(),
      child: Consumer<List<IContentEntity>>(
        builder: (_, pages, __) {
          return model.buildPages(
            pages: pages,
            onPage: (widgets) => SingleChildScrollView(
              child: Column(
                children: widgets
                    .map((w) => [w, SizedBox(height: 20)])
                    .expand((p) => p)
                    .toList(),
              ),
            ),
            onText: (paragraph) => SelectableText(paragraph),
            onImage: (url) => Image.network(url),
            onDefault: () => Container(),
            builder: getHomeView,
          );
        },
      ),
    );
  }

  Widget getHomeView(List<Widget> pages) {
    final content = !(pages?.isEmpty ?? false)
        ? (kIsWeb)
            ? HomeContentDesktop(pages: pages)
            : HomeContentMobile(pages: pages)
        : Container();

    return BaseView(
      storageRepository: locator(),
      child: content,
    );
  }
}
