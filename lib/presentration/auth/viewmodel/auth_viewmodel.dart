import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, bool>((ref) {
  return AuthViewModel();
});

class AuthViewModel extends StateNotifier<bool> {
  AuthViewModel() : super(false); // false = not loading

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔥 SIGN UP
  Future<bool> signUp(
      String name, String email, String password) async {
    try {
      state = true;

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // update display name
      await userCredential.user!.updateDisplayName(name);

      // save to firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'uid': uid,
        'createdAt': DateTime.now(),
      });

      state = false;
      return true;
    } on FirebaseAuthException {
      state = false;
      return false;
    }
  }

  // 🔥 SIGN IN
  Future<bool> signIn(String email, String password) async {
    try {
      state = true;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = false;
      return true;
    } on FirebaseAuthException {
      state = false;
      return false;
    }
  }

  // 🔥 LOGOUT (Bonus 😏)
  Future<void> logout() async {
    await _auth.signOut();
  }
}