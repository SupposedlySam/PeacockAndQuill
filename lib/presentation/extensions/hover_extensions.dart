import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/translate_on_hover.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

extension HoverExtensions on Widget {
  static final html.Element appContainer =
      html.window.document.getElementById('app-container');

  Widget get showPointerOnHover => _setCursorType('pointer');
  Widget get showGrabOnHover => _setCursorType('grab');

  Widget get moveUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }

  Widget _setCursorType(String cursor) {
    return MouseRegion(
      child: this, // the widget we're using the extension on
      onHover: (event) => appContainer.style.cursor = cursor,
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }
}
