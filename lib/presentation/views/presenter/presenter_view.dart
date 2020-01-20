import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_question_entity.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/question_view_model.dart';
import 'package:peacock_and_quill/presentation/views/base_view.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_desktop.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_mobile.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final IContentRepository contentRepository;

  const HomeView({@required this.contentRepository});

  @override
  Widget build(BuildContext context) {
    final presenterViewModel = locator<PresenterViewModel>();
    final questionViewModel = locator<QuestionViewModel>();

    return MultiProvider(
      providers: [
        StreamProvider<List<IQuestionEntity>>.value(
          value: questionViewModel.getQuestionsByUser(),
        ),
        StreamProvider<List<IContentEntity>>.value(
          value: contentRepository.getContent(),
        )
      ],
      child: Consumer2<List<IQuestionEntity>, List<IContentEntity>>(
        builder: (_, questions, pages, __) {
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
              return GestureDetector(
                onLongPress: () {
                  return questionViewModel.showCustomMenu(
                    context,
                    pageIndex,
                    paragraphIndex,
                  );
                },
                onTapDown: questionViewModel.storePosition,
                child: buildText(
                  pageIndex,
                  paragraphIndex,
                  paragraph,
                  questions,
                ),
              );
            },
            onImage: (url) => Image.network(url),
            onDefault: () => Container(),
            builder: getHomeView,
          );
        },
      ),
    );
  }

  Text buildText(
    int pageIndex,
    int paragraphIndex,
    String paragraph,
    List<IQuestionEntity> questions,
  ) {
    if (questions != null) {
      final hasQuestion = questions.any((question) {
        final selection = question.selection;
        return selection.paragraph == paragraphIndex &&
            selection.slide == pageIndex;
      });

      if (hasQuestion) {
        return Text(
          paragraph,
          style: TextStyle(
            backgroundColor: Colors.blueGrey.withAlpha(100),
          ),
        );
      }
    }
    return Text(paragraph);
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
