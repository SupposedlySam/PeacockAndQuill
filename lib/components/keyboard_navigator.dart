import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:peacock_and_quill/locator.dart';
import 'package:peacock_and_quill/view_models/key_press_notifier.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class KeyboardNavigator extends StatelessWidget {
  KeyboardNavigator({
    @required this.focusNode,
    @required this.child,
  });

  static const String arrowUp = "Arrow Up";
  static const String arrowDown = "Arrow Down";
  static const String arrowLeft = "Arrow Left";
  static const String arrowRight = "Arrow Right";

  final Widget child;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: child,
      focusNode: focusNode,
      onKey: handleKey,
    );
  }

  void handleKey(RawKeyEvent rawKeyEvent) {
    final isKeyUpEvent = rawKeyEvent is RawKeyUpEvent;

    if (isKeyUpEvent) {
      final model = locator<KeyPressNotifier>();
      final debugName = rawKeyEvent.logicalKey.debugName;
      final document = html.document;

      switch (debugName) {
        case arrowUp:
          _setFullscreen(document, model);
          break;
        case arrowDown:
          _exitFullscreen(document, model);
          break;
        case arrowLeft:
          model.triggerPrev();
          break;
        case arrowRight:
          model.triggerNext();
          break;
      }
    }
  }

  void _exitFullscreen(html.HtmlDocument document, KeyPressNotifier model) {
    document.exitFullscreen();
    model.setFullscreen(value: false);
  }

  void _setFullscreen(html.HtmlDocument document, KeyPressNotifier model) {
    document.documentElement.requestFullscreen();
    model.setFullscreen(value: true);
  }
}
