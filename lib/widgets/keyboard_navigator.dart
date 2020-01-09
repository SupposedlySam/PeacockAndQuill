import 'package:flutter/cupertino.dart';
import 'package:peacock_and_quill/viewmodels/keyboard_listener_view_model.dart';
import 'dart:html' as html;

import 'package:provider/provider.dart';

class KeyboardNavigator extends StatefulWidget {
  final Widget child;

  const KeyboardNavigator({Key key, this.child}) : super(key: key);

  @override
  _KeyboardNavigatorState createState() => _KeyboardNavigatorState();
}

class _KeyboardNavigatorState extends State<KeyboardNavigator> {
  static const String arrowUp = "Arrow Up";
  static const String arrowDown = "Arrow Down";
  static const String arrowLeft = "Arrow Left";
  static const String arrowRight = "Arrow Right";
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    setState(() => _focusNode = FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<KeyboardListenerViewModel>(context);

    return RawKeyboardListener(
      child: widget.child,
      focusNode: _focusNode,
      onKey: (RawKeyEvent rawKeyEvent) {
        final debugName = rawKeyEvent.logicalKey.debugName;
        final document = html.document;

        switch (debugName) {
          case arrowUp:
            if (document.fullscreenEnabled) {
              document.documentElement.requestFullscreen();
              model.setFullscreen(true);
            }
            break;
          case arrowDown:
            if (document.fullscreenEnabled) {
              document.exitFullscreen();
              model.setFullscreen(false);
            }
            break;
          case arrowLeft:
            // TODO: go back a slide
            model.triggerPrev();
            break;
          case arrowRight:
            // TODO: go to next slide
            model.triggerNext();
            break;
        }
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
