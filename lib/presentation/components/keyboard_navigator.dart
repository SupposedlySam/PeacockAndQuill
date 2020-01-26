import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:peacock_and_quill/presentation/components/lifecycle_managers/focus_node_manager.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_notifier.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class KeyboardNavigator extends StatelessWidget {
  final KeyPressNotifier keyPressNotifier;
  KeyboardNavigator({
    @required this.keyPressNotifier,
    @required this.child,
  });

  static const String arrowUp = "Arrow Up";
  static const String arrowDown = "Arrow Down";
  static const String arrowLeft = "Arrow Left";
  static const String arrowRight = "Arrow Right";

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FocusNodeManager(
      builder: (context, focusNode) {
        return RawKeyboardListener(
          child: child,
          focusNode: focusNode,
          onKey: handleKey,
        );
      },
    );
  }

  void handleKey(RawKeyEvent rawKeyEvent) {
    final isKeyUpEvent = rawKeyEvent is RawKeyUpEvent;

    if (isKeyUpEvent) {
      final debugName = rawKeyEvent.logicalKey.debugName;
      final document = html.document;

      switch (debugName) {
        case arrowUp:
          _setFullscreen(document, keyPressNotifier);
          break;
        case arrowDown:
          _exitFullscreen(document, keyPressNotifier);
          break;
        case arrowLeft:
          keyPressNotifier.triggerPrev();
          break;
        case arrowRight:
          keyPressNotifier.triggerNext();
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
