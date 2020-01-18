import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/firestore/i_storage_repository.dart';
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
    final woodGridUrl = storageRepository.loadImage('wood_grid.jpg');

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          key: locator<GlobalKey<ScaffoldState>>(),
          endDrawer: EndDrawer(),
          body: SafeArea(
            child: FutureProvider<String>.value(
              value: woodGridUrl,
              child: Consumer<String>(
                builder: (_, image, __) {
                  return image != null
                      ? Container(
                          child: buildCenteredView(),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                image.toString(),
                              ), //AssetImage(AssetConstants.woodGrid),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container();
                },
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
