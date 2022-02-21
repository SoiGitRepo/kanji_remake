import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/global_providers.dart';
import 'package:kanji_remake/services/firebase_auth.dart';

final authViewModelProvider =
    ChangeNotifierProvider.autoDispose<AuthViewModel>((_) {
  final target = AuthViewModelImpl(_);
  _.onDispose(() {
    target.dispose();
  });
  return target;
});

abstract class AuthViewModel extends ChangeNotifier {
  bool get ifLoggedIn;
  User? get user;
  String? get email;
  String? get password;
  String? get errorMsg;
  toggleAuthState(bool value);
  signUp(String email, String psw);
  signIn(String email, String psw);
  signOut();
  clearErrorText();
}

class AuthViewModelImpl extends AuthViewModel {
  late bool _ifLoggedIn;
  String? _email;
  String? _password;
  String? _errorText;
  ProviderReference _ref;
  late final StreamSubscription _userSub;
  late AuthService _authService;

  AuthViewModelImpl(
    this._ref,
  ) {
    _authService = _ref.watch(authServiceProvider);
    _userSub = _authService.onUserChanges().listen((user) {
      _ifLoggedIn = _authService.user != null;
      _email = _authService.user?.email;
      notifyListeners();
    });

    // _errorText.onListen = () {
    //   _errorText.add(null);
    // };
  }

  @override
  bool get ifLoggedIn => _ifLoggedIn;

  @override
  User? get user => _authService.user;

  @override
  String? get email => _email;

  @override
  String? get password => _password;

  @override
  String? get errorMsg => _errorText;

  @override
  void dispose() {
    _userSub.cancel();
    super.dispose();
  }

  @override
  void toggleAuthState(bool value) {
    _ifLoggedIn = value;
    notifyListeners();
  }

  @override
  clearErrorText() {
    if (_errorText != null) {
      _errorText = null;
      notifyListeners();
    }
  }

  @override
  Future signIn(String email, String psw) async {
    clearErrorText();
    _errorText = await _authService.signIn(email: email, password: psw);
    notifyListeners();
  }

  @override
  Future signUp(String email, String psw) async {
    clearErrorText();
    _errorText = await _authService.signUp(email: email, password: psw);
    ;
    notifyListeners();
  }

  @override
  signOut() {
    _authService.signOut();
  }
}
