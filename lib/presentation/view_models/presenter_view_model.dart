import 'package:peacock_and_quill/data/repositories/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:peacock_and_quill/domain/use_cases/interaction.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';

class PresenterViewModel with Interaction {
  final presentationRepository = locator<IPresentationRepository>();
  PageController _pageController;

  /// Notify listeners when page changes
  void init(PageController pageController) async {
    await _setInitialSlide(pageController);

    _pageController = pageController..addListener(handleListener);
  }

  Future<int> getInitialSlide() async {
    return presentationRepository.getInitialSlide();
  }

  /// Invoke when page changes based on our use case
  void handleListener() => syncToDevices(_pageController);

  /// Pull the data directly from the repository
  Stream<PresentationEntity> getPresentationStream() {
    return presentationRepository.getPresentationStream();
  }

  Widget buildPages({
    @required
        List<IContentEntity> pages,
    @required
        Widget Function(List<Widget> widgetsForPage) onPage,
    @required
        Widget Function(String) onText,
    @required
        Widget Function(String) onImage,
    @required
        Widget Function() onDefault,
    @required
        Widget Function(
      List<Widget> widgets,
    )
            builder,
  }) {
    if (pages != null) {
      return builder(pages
          .map((page) => onPage(page.data
              .map((data) => onPage(data.value
                  .split('\\n')
                  .map(
                    (p) => onText(p),
                  )
                  .toList()))
              .toList()))
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
      syncToDevices(pageController);
    }
  }
}
