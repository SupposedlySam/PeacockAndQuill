import 'package:flutter/material.dart';

typedef FocusBuilder = Widget Function(BuildContext, FocusNode);

/// Manage the lifecycle of a FocusNode
class FocusNodeManager extends StatefulWidget {
  FocusNodeManager({@required this.builder});

  final FocusBuilder builder;

  @override
  _FocusNodeManagerState createState() => _FocusNodeManagerState();
}

class _FocusNodeManagerState extends State<FocusNodeManager> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    setState(() => _focusNode = FocusNode());
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _focusNode);

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
