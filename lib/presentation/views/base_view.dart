import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_storage_repository.dart';
import 'package:peacock_and_quill/domain/asset_types/background_image.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/components/centered_view.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BaseView extends StatelessWidget {
  const BaseView({
    @required this.child,
    @required this.storageRepository,
  });

  final Widget child;
  final IStorageRepository storageRepository;

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Provider.of<BackgroundImage>(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          key: locator<GlobalKey<ScaffoldState>>(),
          endDrawer: EndDrawer(),
          body: SafeArea(
            child: Container(
              child: buildCenteredView(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: backgroundImage.value,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCenteredView() {
    return CenteredView(
      child: Container(
        color: Colors.black.withAlpha(170),
        child: Column(
          children: <Widget>[
            NavigationBar(),
            Expanded(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
