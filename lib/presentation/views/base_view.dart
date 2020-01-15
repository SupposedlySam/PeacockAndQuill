import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/constants.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/components/centered_view.dart';
import 'package:peacock_and_quill/presentation/components/end_drawer.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/nav_bar_logo.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BaseView extends StatelessWidget {
  const BaseView({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage(AssetConstants.woodGrid),
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
