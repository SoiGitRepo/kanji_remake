import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncViewModelProvider =
    ChangeNotifierProvider<SyncViewModelImpl>((ref) => SyncViewModelImpl());

abstract class SyncViewModel extends ChangeNotifier {
  bool get ifSync;
  void toggleSyncState(bool value);
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
