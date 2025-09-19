import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_remake/providers/app_providers.dart';

final syncViewModelProvider =
    ChangeNotifierProvider<SyncViewModelImpl>((ref) => SyncViewModelImpl(ref));

abstract class SyncViewModel extends ChangeNotifier {
  bool get ifSync;
  String? get errorMsg;
  Future<void> toggleSyncState(bool value);
}

class SyncViewModelImpl extends SyncViewModel {
  bool _ifSync = false;
  String? _error;
  final Ref _ref;

  SyncViewModelImpl(this._ref);

  void _setError(String? msg) {
    _error = msg;
    notifyListeners();
  }

  @override
  String? get errorMsg => _error;

  @override
  Future<void> toggleSyncState(bool value) async {
    _setError(null);
    final sync = _ref.read(syncServiceProvider);
    if (value) {
      try {
        final available = await sync.isAvailable();
        if (!available) {
          _ifSync = false;
          final useICloud = _ref.read(isICloudSyncProvider);
          _setError(useICloud
              ? '未启用 iCloud Key-Value，请在系统设置/Xcode 启用后重试'
              : '未登录，开启同步需要先登录账户');
          return;
        }
        await sync.enable();
        _ifSync = true;
      } catch (e) {
        _ifSync = false;
        _setError('开启同步失败：$e');
        return;
      }
    } else {
      try {
        await sync.disable();
      } catch (e) {
        _setError('关闭同步时出现问题：$e');
      } finally {
        _ifSync = false;
      }
    }
    notifyListeners();
  }

  @override
  bool get ifSync => _ifSync;
}
