import 'dart:async';

import 'package:flutter/material.dart';

class StateManager<T extends ChangeNotifier> extends StatefulWidget {
  final FutureOr<T> Function() changeNotifier;
  final Function(T) onReady;
  final Widget Function(BuildContext, T) builder;
  final bool showLoadingIndicator;
  final bool shouldDispose;

  const StateManager({
    Key key,
    @required this.changeNotifier,
    @required this.builder,
    this.onReady,
    this.showLoadingIndicator = true,
    this.shouldDispose = false,
  }) : super(key: key);

  @override
  _StateManagerState createState() => _StateManagerState<T>();
}

class _StateManagerState<T extends ChangeNotifier>
    extends State<StateManager<T>> {
  T _changeNotifier;

  @override
  void initState() {
    super.initState();
    _handleInitState();
  }

  Future<void> _handleInitState() async {
    final result = await widget.changeNotifier();
    result.addListener(() {
      if (mounted) setState(() {});
    });
    if (mounted) setState(() => _changeNotifier = result);
    if (widget.onReady != null) widget.onReady(result);
  }

  @override
  void dispose() {
    if (widget.shouldDispose) _changeNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _changeNotifier == null && widget.showLoadingIndicator
        ? _loading()
        : widget.builder(context, _changeNotifier);
  }

  Widget _loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LimitedBox(
          maxHeight: 50,
          child: AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
