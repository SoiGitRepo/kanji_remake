import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanji_remake/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectbox/objectbox.dart' as objectbox;

objectbox.Store? useObjectBoxStore() {
  return use(ObjectBoxStoreHook());
}

class ObjectBoxStoreHook extends Hook<objectbox.Store?> {
  const ObjectBoxStoreHook() : super();

  @override
  _ObjectBoxHookState createState() => _ObjectBoxHookState();
}

class _ObjectBoxHookState
    extends HookState<objectbox.Store?, ObjectBoxStoreHook> {
  objectbox.Store? _store;

  @override
  void initHook() {
    super.initHook();
    getExternalStorageDirectory().then((value) {
      openStore(directory: value?.path).then((value) {
        setState(() {
          _store = value;
        });
      });
    });
  }

  @override
  objectbox.Store? build(BuildContext context) {
    return _store;
  }

  @override
  void dispose() {
    super.dispose();
    _store?.close();
  }
}
