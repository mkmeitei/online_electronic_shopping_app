import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _username = "";
  String get username => _username;

  String _email = "";
  String get email => _email;

  UserInfo() {
    getUsername();
    getEmail();
  }

  // get username
  void getUsername() async {
    try {
      _username = _firebaseAuth.currentUser!.displayName ?? "User";
      notifyListeners();
    } catch (e) {
      print("not signed in");
    }
  }

  //get email address
  void getEmail() async {
    try {
      _email = _firebaseAuth.currentUser!.email ?? "Email";
      notifyListeners();
    } catch (e) {
      print("No email");
    }
  }

}
