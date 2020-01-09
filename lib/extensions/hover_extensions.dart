import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:peacock_and_quill/widgets/translate_on_hover.dart';

extension HoverExtensions on Widget {
  static final html.Element appContainer =
      html.window.document.getElementById('app-container');

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this, // the widget we're using the extension on
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }

  Widget get moveUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }
}
