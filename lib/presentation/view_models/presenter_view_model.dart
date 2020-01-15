import 'package:peacock_and_quill/data/repositories/firestore/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:peacock_and_quill/domain/use_cases/interaction.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';

class PresenterViewModel extends ChangeNotifier with Interaction {
  final presentationRepository = locator<IPresentationRepository>();
  PageController _pageController;

  // Properties
  int _index = 0;
  int get index => _index;

  /// Notify listeners when page changes
  void listen(PageController pageController) {
    _pageController = pageController
      ..addListener(handleListener)
      ..removeListener(handleListener);
  }

  /// Invoke when page changes
  void handleListener() {
    final index = syncToDevices(_pageController);
    setIndex(index);
  }

  Stream<PresentationEntity> getPresentation() {
    return presentationRepository.getPresentation();
  }

  /// Update the current index
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
