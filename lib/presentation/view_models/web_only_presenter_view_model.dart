import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/web/i_web_only_presentation_use_case.dart';

class WebOnlyPresenterViewModel extends ChangeNotifier {
  final IWebOnlyPresentationUseCase presentationUseCase;

  WebOnlyPresenterViewModel({
    @required this.presentationUseCase,
  });

  Future<void> getPresentations() async {
    await presentationUseCase.getPresentations();
    notifyListeners();
  }
}
