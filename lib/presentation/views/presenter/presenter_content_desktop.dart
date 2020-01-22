import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/components/lifecycle_managers/key_press_page_manager.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:provider/provider.dart';

class HomeContentDesktop extends StatelessWidget {
  final IContentRepository contentRepository;

  const HomeContentDesktop({@required this.contentRepository});

  @override
  Widget build(BuildContext context) {
    final presenterViewModel = locator<PresenterViewModel>();

    return StreamProvider<List<IContentEntity>>.value(
      value: contentRepository.getContent(),
      child: Consumer<List<IContentEntity>>(
        builder: (_, pages, __) {
          return presenterViewModel.buildPages(
            pages: pages,
            onPage: (widgets) => SingleChildScrollView(
              child: Column(
                children: widgets
                    .map((w) => [w, SizedBox(height: 20)])
                    .expand((p) => p)
                    .toList(),
              ),
            ),
            onText: (pageIndex, paragraphIndex, paragraph) {
              return Text(paragraph);
            },
            onImage: (url) => Image.network(url),
            onDefault: () => Container(),
            builder: (pages) => KeyPressPageManager(
              builder: (context, controller) {
                // listen to the page transition
                presenterViewModel.init(controller);

                return PageView(
                  controller: controller,
                  children: pages
                      .map((page) => Center(
                              child: Container(
                            color: Colors.black38,
                            padding: const EdgeInsets.all(40),
                            child: page,
                          )))
                      .toList(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
