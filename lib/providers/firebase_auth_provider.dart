import 'package:bus_seat_booking_user/db/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class FirebaseAuthProvider with ChangeNotifier{
  final _auth = FirebaseAuth.instance;
  UserModel? userModel;
  String errMsg = '';

  // G E T T E R    M E T H O D
  User? get currentUser => _auth.currentUser;
  bool get isUserAnonymous => currentUser!.isAnonymous;
  User? get googleUser {
    if (currentUser != null && currentUser!.providerData.any((userInfo) => userInfo.providerId == 'google.com')) {
      return currentUser;
    }
    return null;
  }

  // S E T
  Future<void> saveNewUser(UserModel user){
    return DbHelper.saveNewUser(user);
  }

  // G E T
  Future<void> getUserInfo() async {
      final snapshot = await DbHelper.getUserInfo(currentUser!.uid);
      if(snapshot.exists){
        userModel = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
  }

  Future<bool> doesUserExit () {
    return DbHelper.doesUserExit(currentUser!.uid);
  }

  // U P D A T E
  updateUSerProfile (UserModel user) async {
    try{
      await DbHelper.updateUserProfile(user);
    } catch (error) {
      errMsg = 'Failed to update profile: $error';
    }
  }

  // L O G I N
  Future<UserCredential?> anonymousUserLogin() async{
    try {
      final userCredential = await _auth.signInAnonymously();
      return userCredential;
    } on FirebaseAuthException catch (error) {
      errMsg = error.message ?? 'Something went wrong';
    }
    return null;
  }

  Future<UserCredential> loginUser(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Ensure the user signs out from any existing Google session
    await GoogleSignIn().signOut();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //L O G I N   C O N V E R T I O N
  Future<UserCredential> convertAnonymousUserToPermanentAccount(String email, String password) async {
    final credential = EmailAuthProvider.credential(email: email, password: password);
    final userCredential = await _auth.currentUser!.linkWithCredential(credential);
    return userCredential;
  }

  // V E R I F I C A T I O N    C H E C K
  Future<bool> isEmailVerified() async {
    return currentUser!.emailVerified;
  }

  Future<void> sendVerificationMail() async {
    currentUser!.sendEmailVerification();
  }

  // L O G O U T
  Future<void> logout() {
    return _auth.signOut();
  }
}