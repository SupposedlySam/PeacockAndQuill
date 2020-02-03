import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/web/i_web_only_presentation_use_case.dart';
import 'package:peacock_and_quill/presentation/routing/router.dart';

class HomeContentWebViewModel extends ChangeNotifier {
  final NavigatorState navigator;
  final IWebOnlyPresentationUseCase presentationUseCase;
  final IUserRepository userRepository;
  final IStorageRepository storageRepository;

  HomeContentWebViewModel({
    @required this.navigator,
    @required this.presentationUseCase,
    @required this.userRepository,
    @required this.storageRepository,
  });

  List<IPresentationEntity> _presentations;
  List<IPresentationEntity> get presentations => _presentations;

  Future<void> getPresentations() async {
    _presentations = await presentationUseCase.getPresentations();
    notifyListeners();
  }

  Future<void> handlePresentationSelect(String presentationId) async {
    await userRepository.setActivePresentation(presentationId);
    navigator.pushReplacementNamed(RouteName.presenterContent);
  }
}
