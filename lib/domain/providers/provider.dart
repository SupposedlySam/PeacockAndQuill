import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/domain/asset_types/background_image.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
import 'package:peacock_and_quill/domain/use_cases/authorization.dart';
import 'package:peacock_and_quill/presentation/view_models/nav_bar_view_model.dart';
import 'package:peacock_and_quill/presentation/view_models/presenter_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'locator.dart';

class Providers extends StatelessWidget {
  final Widget child;

  Providers({@required this.child});

  List<SingleChildWidget> get changeNotifierProviders {
    return [
      ChangeNotifierProvider<NavBarViewModel>.value(
        value: locator<NavBarViewModel>(),
      ),
    ];
  }

  List<SingleChildWidget> get streamProviders {
    return [
      StreamProvider<PresentationEntity>.value(
        initialData: PresentationEntity(currentSlide: 0, initialSlide: 0),
        value: locator<PresenterViewModel>().getPresentationStream(),
      ),
      StreamProvider<FirebaseUser>.value(
        value: locator<Authorization>().userStream,
      ),
    ];
  }

  List<SingleChildWidget> get assetProviders {
    return [
      ..._backgroundImageProvider(),
    ];
  }

  List<SingleChildWidget> _backgroundImageProvider() => [
        FutureProvider<String>.value(
          value: locator<IStorageRepository>().loadImage('wood_grid.jpg'),
        ),
        ProxyProvider<String, BackgroundImage>(
          update: (_, url, __) => url != null
              ? BackgroundImage(NetworkImage(url.toString()))
              : null,
          updateShouldNotify: (n, o) => n?.value != o?.value,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...changeNotifierProviders,
        ...streamProviders,
        ...assetProviders,
      ],
      child: child,
    );
  }
}
