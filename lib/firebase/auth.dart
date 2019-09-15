import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habito_de_ler/model/user.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseAuth {
  Future<String> currentUser();

  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<FirebaseUser> googleSignIn();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;

  // ignore: close_sinks
  PublishSubject loading = PublishSubject();

  Auth() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

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

  // ignore: missing_return
  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.idToken);

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    updateUserData(user);

    return user;
  }

  // ignore: missing_return
  Future<void> updateUserData(FirebaseUser fireBaseUser) async {
    DocumentReference ref = _db.collection('users').document(fireBaseUser.uid);

    User user = new User()
      ..username = fireBaseUser.displayName
      ..email = fireBaseUser.email
      ..booksFavorites = []
      ..booksReading = []
      ..createDate = DateTime.now();

    return ref.setData(user.toJson(), merge: true);
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}
