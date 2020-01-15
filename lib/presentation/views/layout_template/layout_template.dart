import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'layout_template_desktop.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({@required this.navigator});

  final Navigator navigator;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LayoutTemplateDesktop(navigator: navigator),
    );
  }
}
