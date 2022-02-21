import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;
  Future signUp({required String email, required String password});
  Future verifyEmail();
  Future signIn({required String email, required String password});
  Future signOut();
  Stream<User?> onUserChanges();
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  //SIGN UP METHOD
  @override
  Future signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        return ('Invalid Email.');
      }
    } catch (e) {
      return (e);
    }
  }

  //用于发送激活邮箱邮件的函数
  @override
  Future verifyEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Stream<User?> onUserChanges() {
    return _auth.userChanges();
  }

  //SIGN IN METHOD
  @override
  Future signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        return ('Invalid Email.');
      }
    } catch (e) {
      return (e);
    }
  }

  //SIGN OUT METHOD
  @override
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
