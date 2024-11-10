import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // user sign in
  Future<UserCredential> signInWithEmailAndPassowrd(
      String userEmail, String userPassword) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // user sign up
  Future<UserCredential> signUpWithEmailAndPassowrd(
      String userEmail, String userPassword) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //vlogout
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
