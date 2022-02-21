import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final syncViewModelProvider =
    ChangeNotifierProvider((_) => SyncViewModelImpl());

abstract class SyncViewModel extends ChangeNotifier {
  bool get ifSync;
  toggleSyncState(bool value);
}

class SyncViewModelImpl extends SyncViewModel {
  bool _ifSync = false;

  @override
  void toggleSyncState(bool value) {
    _ifSync = value;
    notifyListeners();
  }

  @override
  bool get ifSync => _ifSync;
}
