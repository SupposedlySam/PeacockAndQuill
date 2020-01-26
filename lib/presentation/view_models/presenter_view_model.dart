import 'package:flutter/services.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_content_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_presentation_use_case.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';

class PresenterViewModel extends ChangeNotifier {
  PageController _pageController;
  final IPresentationUseCase presentationUseCase;

  PresenterViewModel({
    @required this.presentationUseCase,
  });

  /// Notify listeners when page changes
  void init(PageController pageController) async {
    await _setInitialSlide(pageController);

    _pageController = pageController..addListener(handleListener);
  }

  Future<int> getInitialSlide() async {
    return presentationUseCase.getInitialSlide();
  }

  Future<int> getCurrentSlide() async {
    return presentationUseCase.getCurrentSlide();
  }

  /// Invoke when page changes based on our use case
  void handleListener() => presentationUseCase.syncToDevices(_pageController);

  /// Pull the data directly from the repository
  Stream<IPresentationEntity> getPresentationStream() {
    return presentationUseCase.getPresentationStream();
  }

  Future<String> getHighlightedText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data.text;
  }

  Widget buildPages({
    @required List<IContentEntity> pages,
    @required Widget Function(List<Widget> widgetsForPage) onPage,
    @required Widget Function(int, int, String) onText,
    @required Widget Function(String) onImage,
    @required Widget Function() onDefault,
    @required Widget Function(List<Widget> widgets) builder,
  }) {
    if (pages != null) {
      return builder(pages
          .asMap()
          .map((pageIndex, page) => MapEntry(
              pageIndex,
              onPage(page.data
                  .map((data) => onPage(data.value
                      .split('\\n')
                      .asMap()
                      .map(
                        (paragraphIndex, p) => MapEntry(
                          paragraphIndex,
                          onText(pageIndex, paragraphIndex, p),
                        ),
                      )
                      .values
                      .toList()))
                  .toList())))
          .values
          .toList());
    }

    return onDefault();
  }

  Future _setInitialSlide(PageController pageController) async {
    if (_pageController == null) {
      final initialSlide = await getInitialSlide();

      // Move to the initial slide
      pageController.jumpToPage(initialSlide);

      // Sync the currentSlide
      presentationUseCase.syncToDevices(pageController);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
