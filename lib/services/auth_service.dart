import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? error;
  final User? user = FirebaseAuth.instance.currentUser;

  User? currentUser() {
    return user;
  }

  login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      error = e.code;
      return false;
    }
  }

  signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      error = e.code;
      return false;
    }
  }
}
