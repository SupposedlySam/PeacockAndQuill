import 'package:flutter/material.dart';
import 'package:peacock_and_quill/views/home/home_content_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: HomeContentDesktop(),
      mobile: HomeContentDesktop(),
    );
  }
}
