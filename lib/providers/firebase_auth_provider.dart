import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';

class FirebaseAuthProvider with ChangeNotifier{
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> anonymousUserLogin() async{
    try {
      final userCredential = await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }

  Future<bool> isEmailVerified() async {
    return currentUser!.emailVerified;
  }

  Future<void> sendVerificationMail() async {
    currentUser!.sendEmailVerification();
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}