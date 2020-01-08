import 'package:flutter/material.dart';
import 'package:peacock_and_quill/views/layout_template/layout_template_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({
    @required this.navigator,
  });

  final Navigator navigator;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: LayoutTemplateDesktop(navigator: navigator),
      mobile: LayoutTemplateDesktop(navigator: navigator),
    );
  }
}
