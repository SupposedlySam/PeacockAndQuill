import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/content_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/web/content_repository_web.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/presentation_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/web/presentation_repository_web.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/question_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/web/question_repository_web.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/storage_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/web/storage_repository_web.dart';
import 'package:peacock_and_quill/data/repositories/firestore/mobile/user_repository_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/data/repositories/firestore/web/user_repository_web.dart';
import 'package:peacock_and_quill/data/repositories/firestore/web/web_only_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_content_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/web/i_web_only_presentation_repository.dart';
import 'package:peacock_and_quill/domain/use_cases/authorization_use_case.dart';
import 'package:peacock_and_quill/domain/use_cases/content_use_case.dart';
import 'package:peacock_and_quill/domain/use_cases/presentation_use_case.dart';
import 'package:peacock_and_quill/domain/use_cases/question_use_case.dart';
import 'package:peacock_and_quill/domain/use_cases/web/web_only_presentation_use_case.dart';
import 'package:peacock_and_quill/presentation/asset_types/background_image.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/i_logo.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/logo/logo_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/presentation/components/navigation_bar/logo/logo_web.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar_imports.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_all_authorization_use_case.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_content_use_case.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_presentation_use_case.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_question_use_case.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/web/i_web_only_presentation_use_case.dart';
import 'package:peacock_and_quill/presentation/routing/navigation_interceptor.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_notifier.dart';
import 'package:peacock_and_quill/presentation/view_models/nav_bar_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/public/public_view_model_mobile.dart'
    if (dart.library.html) 'package:peacock_and_quill/presentation/view_models/public/public_view_model_web.dart';
import 'package:peacock_and_quill/presentation/view_models/question_view_model.dart';
import 'package:peacock_and_quill/presentation/views/components/font_size_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers extends StatelessWidget {
  final Widget child;

  Providers({@required this.child});

  List<SingleChildWidget> get _globalKeys => [
        Provider(create: (_) => GlobalKey<NavigatorState>()),
      ];

  List<SingleChildWidget> get _otherProviders => [
        Provider<ILogo>(create: (_) => Logo()),
        Provider(create: (_) => NavigationInterceptor()),
        ChangeNotifierProvider(
          create: (_) => FontSizeNotifier(24),
        )
      ];

  List<SingleChildWidget> get _publicRepositoryProviders => [
        Provider<IStorageRepository>(
          create: (_) => StorageRepository(),
        ),
        Provider<IUserRepository>(
          create: (_) => UserRepository(),
        ),
        Provider<IPresentationRepository>(
          create: (_) => PresentationRepository(),
        ),
      ];

  List<SingleChildWidget> get _webOnlyPublicRepositoryProviders => [
        Provider<IWebOnlyPresentationRepository>(
          create: (_) => WebOnlyPresentationRepository(),
        ),
      ];

  List<SingleChildWidget> get _publicUseCaseProviders => [
        ProxyProvider<IUserRepository, IAllAuthorizationUseCase>(
          update: (_, userRepository, __) {
            return AuthorizationUseCase(
              userRepository: userRepository,
            );
          },
        ),
        ProxyProvider<IPresentationRepository, IPresentationUseCase>(
          update: (_, presentationRepository, __) {
            return PresentationUseCase(
              presentationRepository: presentationRepository,
            );
          },
        ),
      ];

  List<SingleChildWidget> get _webOnlyPublicUseCaseProviders => [
        ProxyProvider2<IWebOnlyPresentationRepository, IUserRepository,
            IWebOnlyPresentationUseCase>(
          update: (_, presentationRepository, userRepository, __) {
            return WebOnlyPresentationUseCase(
              presentationRepository: presentationRepository,
              userRepository: userRepository,
            );
          },
        ),
      ];

  List<SingleChildWidget> get _publicViewModelProviders => [
        ChangeNotifierProvider(create: (_) => KeyPressNotifier()),
        ChangeNotifierProvider(create: (_) => NavBarViewModel(value: false)),
        ChangeNotifierProvider<BasePublicViewModel>(
          create: (context) => PublicViewModel(
            userRepository:
                Provider.of<IUserRepository>(context, listen: false),
            presentationRepository:
                Provider.of<IPresentationRepository>(context, listen: false),
            authorizationUseCase:
                Provider.of<IAllAuthorizationUseCase>(context, listen: false),
          ),
        ),
      ];

  List<SingleChildWidget> get streamProviders {
    return [
      StreamProvider<FirebaseUser>(
        create: (context) {
          return Provider.of<IAllAuthorizationUseCase>(context, listen: false)
              .userStream;
        },
      ),
    ];
  }

  List<SingleChildWidget> get assetProviders {
    return [
      FutureProvider<BackgroundImage>(
        create: (context) {
          final storageRepository =
              Provider.of<IStorageRepository>(context, listen: false);
          return _backgroundImageProvider(storageRepository);
        },
      ),
      FutureProvider<PublicBackgroundImage>(
        create: (context) {
          final storageRepository =
              Provider.of<IStorageRepository>(context, listen: false);
          return _publicBackgroundImageProvider(storageRepository);
        },
      ),
      if (kIsWeb)
        FutureProvider<WebSelectPresentationBackgroundImage>(
          create: (context) {
            final storageRepository =
                Provider.of<IStorageRepository>(context, listen: false);
            return _webSelectPresentationBackgroundImageProvider(
                storageRepository);
          },
        ),
    ];
  }

  Future<BackgroundImage> _backgroundImageProvider(
    IStorageRepository storageRepository,
  ) async {
    final url = await storageRepository.loadImage('wood_grid.jpg');
    return BackgroundImage(NetworkImage(url));
  }

  Future<PublicBackgroundImage> _publicBackgroundImageProvider(
    IStorageRepository storageRepository,
  ) async {
    final url = await storageRepository.loadImage('peacock_background.jpg');
    return PublicBackgroundImage(NetworkImage(url));
  }

  Future<WebSelectPresentationBackgroundImage>
      _webSelectPresentationBackgroundImageProvider(
    IStorageRepository storageRepository,
  ) async {
    final url = await storageRepository.loadImage('peacock_web_background.jpg');
    return WebSelectPresentationBackgroundImage(NetworkImage(url));
  }

  List<SingleChildWidget> get publicProviders => [
        ..._globalKeys,
        ..._publicRepositoryProviders,
        if (kIsWeb) ..._webOnlyPublicRepositoryProviders,
        ..._publicUseCaseProviders,
        if (kIsWeb) ..._webOnlyPublicUseCaseProviders,
        ..._publicViewModelProviders,
        ...streamProviders,
        ...assetProviders,
        ..._otherProviders,
      ];

  List<SingleChildWidget> get _authorizedRepositoryProviders => [
        Provider<IContentRepository>(
          create: (_) => ContentRepository(),
        ),
        Provider<IQuestionRepository>(
          create: (_) => QuestionRepository(),
        ),
      ];

  List<SingleChildWidget> get _authorizedUseCaseProviders => [
        ProxyProvider2<IAllAuthorizationUseCase, IQuestionRepository,
            IQuestionUseCase>(
          update: (_, authorizationUseCase, questionRepository, __) {
            return QuestionUseCase(
              authorizationUseCase: authorizationUseCase,
              questionRepository: questionRepository,
            );
          },
        ),
        ProxyProvider<IContentRepository, IContentUseCase>(
          update: (_, contentRepository, __) {
            return ContentUseCase(
              contentRepository: contentRepository,
            );
          },
        ),
      ];

  List<SingleChildWidget> get _authorizedViewModelProviders => [
        ChangeNotifierProvider<PresenterViewModel>(create: (context) {
          return PresenterViewModel(
            presentationUseCase: Provider.of(context, listen: false),
          );
        }),
        ProxyProvider<IQuestionUseCase, QuestionViewModel>(
          update: (_, questionUseCase, __) {
            return QuestionViewModel(
              questionUseCase: questionUseCase,
            );
          },
        ),
      ];

  List<SingleChildWidget> get authorizedProviders => [
        ..._authorizedRepositoryProviders,
        ..._authorizedUseCaseProviders,
        ..._authorizedViewModelProviders,
      ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: publicProviders,
      child: Consumer<FirebaseUser>(
        builder: (context, user, _) {
          final isAuthorized = user != null;

          return isAuthorized
              ? MultiProvider(providers: authorizedProviders, child: child)
              : child;
        },
      ),
    );
  }
}
