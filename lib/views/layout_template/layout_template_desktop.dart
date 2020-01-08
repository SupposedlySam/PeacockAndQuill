import 'package:flutter/material.dart';
import 'package:peacock_and_quill/widgets/centered_view/centered_view.dart';
import 'package:peacock_and_quill/widgets/navigation_bar/navigation_bar.dart';
import 'package:peacock_and_quill/widgets/navigation_drawer/navigation_drawer.dart';
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
        body: CenteredView(
          child: Column(
            children: <Widget>[
              NavigationBar(),
              Expanded(child: navigator),
            ],
          ),
        ),
      ),
    );
  }
}
