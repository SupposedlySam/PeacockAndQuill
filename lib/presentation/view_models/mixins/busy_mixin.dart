import 'package:flutter/material.dart';

mixin BusyMixin on ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void indicateBusyAsync(Future Function() callback) async {
    setBusy(value: true);
    await callback();
    setBusy(value: false);
  }

  void indicateBusy(VoidCallback callback) {
    setBusy(value: true);
    callback();
    setBusy(value: false);
  }

  void setBusy({@required bool value}) {
    _busy = value;
    notifyListeners();
  }
}
