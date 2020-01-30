import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_content_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/question_view_model.dart';
import 'package:peacock_and_quill/presentation/views/components/stored_network_image.dart';
import 'package:provider/provider.dart';

class PresenterContentMobile extends StatelessWidget {
  final IStorageRepository storageRepository;
  final int currentSlide;
  final bool isActive;

  const PresenterContentMobile({
    @required this.storageRepository,
    @required this.currentSlide,
    @required this.isActive,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentUseCase = Provider.of<IContentUseCase>(context);
    final presenterViewModel = Provider.of<PresenterViewModel>(context);
    final questionViewModel = Provider.of<QuestionViewModel>(context);

    return isActive
        ? activeView(
            context: context,
            contentUseCase: contentUseCase,
            questionViewModel: questionViewModel,
            presenterViewModel: presenterViewModel,
          )
        : Center(
            child: Text(
              'Thanks for joining! Please wait for the presentation to begin.',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          );
  }

  MultiProvider activeView({
    BuildContext context,
    IContentUseCase contentUseCase,
    QuestionViewModel questionViewModel,
    PresenterViewModel presenterViewModel,
  }) {
    return MultiProvider(
      providers: [
        StreamProvider<List<IQuestionEntity>>.value(
          value: questionViewModel.getQuestionsByUser(),
        ),
        StreamProvider<List<IContentEntity>>.value(
          value: contentUseCase.getContent(),
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
            onImage: (url) => StoredNetworkImage(
              storageRepository: storageRepository,
              url: url,
            ),
            onDefault: () => Container(),
            builder: (pages) => pages[currentSlide],
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
}
