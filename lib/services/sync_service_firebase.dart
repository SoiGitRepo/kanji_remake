import 'dart:async';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanji_remake/services/sync_service.dart';

/// Android 平台：使用 Firebase Firestore 实现的同步服务
class FirebaseSyncService implements SyncService {
  FirebaseSyncService();

  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  @override
  Future<bool> isAvailable() async {
    // 仅在 Android 上启用
    return Platform.isAndroid;
  }

  @override
  Future<void> enable() async {
    // Android 端只要已登录即可认为可用
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('未登录，无法启用云同步');
    }
    // 可在此进行必要的初始化，例如创建空文档
    await _ensureProgressDoc(user.uid);
  }

  @override
  Future<void> disable() async {
    // Android 端关闭同步无需删除云端数据，仅重置本地状态由调用方处理
    return;
  }

  Future<void> _ensureProgressDoc(String uid) async {
    final doc = _db.collection('users').doc(uid).collection('meta').doc('progress_meta');
    final snap = await doc.get();
    if (!snap.exists) {
      await doc.set({'createdAt': FieldValue.serverTimestamp()});
    }
  }

  @override
  Future<void> pushProgress(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('未登录，无法推送进度');
    }
    final doc = _db.collection('users').doc(user.uid).collection('data').doc('progress');
    await doc.set({
      'payload': data,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<Map<String, dynamic>?> pullProgress() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('未登录，无法拉取进度');
    }
    final doc = await _db.collection('users').doc(user.uid).collection('data').doc('progress').get();
    if (!doc.exists) return null;
    final map = doc.data();
    final payload = (map ?? {})['payload'];
    if (payload is Map<String, dynamic>) return payload;
    return null;
  }
}
