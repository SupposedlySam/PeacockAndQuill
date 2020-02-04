import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_content_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:peacock_and_quill/presentation/views/base_view.dart';
import 'package:peacock_and_quill/presentation/views/components/font_size_notifier.dart';
import 'package:peacock_and_quill/presentation/views/components/stored_network_image.dart';
import 'package:peacock_and_quill/state/state_manager.dart';
import 'package:provider/provider.dart';

class PresenterContentWeb extends StatelessWidget {
  final IStorageRepository storageRepository;

  const PresenterContentWeb({
    Key key,
    this.storageRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenterViewModel = Provider.of<PresenterViewModel>(context);
    final contentUseCase = Provider.of<IContentUseCase>(context);

    return StreamProvider<List<IContentEntity>>(
      create: (_) => contentUseCase.getContent(),
      child: Consumer<List<IContentEntity>>(
        builder: (_, pages, __) {
          return BaseView(
            child: presenterViewModel.buildPages(
              pages: pages,
              onPage: (widgets) => Flex(
                  direction: Axis.horizontal,
                  children: widgets
                      .map((w) => Flexible(child: Center(child: w)))
                      .toList()),
              onGroup: (widgets) => SingleChildScrollView(
                child: Column(
                  children: widgets
                      .map((w) => [w, SizedBox(height: 20)])
                      .expand((p) => p)
                      .toList(),
                ),
              ),
              onText: (pageIndex, sectionIndex, content) {
                return Text(
                  content,
                  style: TextStyle(
                      fontSize: Provider.of<FontSizeNotifier>(context).value),
                );
              },
              onImage: (url) {
                return url.contains('http')
                    ? Image.network(url)
                    : StoredNetworkImage(
                        storageRepository: storageRepository,
                        url: url,
                      );
              },
              onDefault: () => Container(),
              builder: (pages) {
                return StateManager<KeyPressViewModel>(
                  changeNotifier: () => Provider.of<KeyPressViewModel>(context),
                  onReady: (model) => presenterViewModel.init(model.controller),
                  builder: (context, model) {
                    return PageView(
                      controller: model.controller,
                      children: pages
                          .map((page) => Center(
                                  child: Container(
                                color: Color(0xAA0F0F0F),
                                padding: const EdgeInsets.all(40),
                                child: page,
                              )))
                          .toList(),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
