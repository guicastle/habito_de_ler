import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

abstract class BaseAuth {
  Future<String> currentUser();
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ignore: missing_return
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return user.uid;
    } on PlatformException catch (e) {
      print('Code error: ${e.code}');
    }
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
