import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/constants.dart';
import 'package:peacock_and_quill/presentation/components/centered_view.dart';
import 'package:peacock_and_quill/presentation/components/navigation_bar/navigation_bar.dart';
import 'package:peacock_and_quill/presentation/components/navigation_drawer/navigation_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplateDesktop extends StatelessWidget {
  const LayoutTemplateDesktop({
    @required this.navigator,
  });

  final Navigator navigator;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.Mobile
            ? NavigationDrawer()
            : null,
        body: Container(
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
  }

  Widget buildCenteredView() {
    return CenteredView(
      child: Column(
        children: <Widget>[
          NavigationBar(),
          Expanded(child: navigator),
        ],
      ),
    );
  }
}
