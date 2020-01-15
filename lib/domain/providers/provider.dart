import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/entities/presentation_entity.dart';
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
      ChangeNotifierProvider<PresenterViewModel>.value(
        value: locator<PresenterViewModel>(),
      ),
    ];
  }

  List<SingleChildWidget> get streamProviders {
    return [
      // StreamProvider<PresentationEntity>.value(
      //   initialData: PresentationEntity(currentSlide: 2),
      //   value: locator<PresenterViewModel>().getPresentation(),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...changeNotifierProviders,
        ...streamProviders,
      ],
      child: child,
    );
  }
}
