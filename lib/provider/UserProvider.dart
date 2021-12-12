import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  FirebaseAuth auth;
  bool get isSigned => auth.currentUser != null;

  UserProvider() {
    auth = FirebaseAuth.instance;
    auth.setPersistence(Persistence.LOCAL);
    _addListenerUser();
  }

  _addListenerUser() {
    FirebaseAuth.instance.authStateChanges().listen((User listenUser) {
      if (listenUser == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      notifyListeners();
    });
  }

  Future<void> signOut() async => await auth.signOut();

  /// Only Web Google Auth
  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'example@gmail.com'});

    return await auth.signInWithPopup(
        googleProvider); // UserCredential userCredentialBySignWithGoogle
  }

  Future<UserCredential> signInWithEmail(
      {String email, String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('signInWidthEmail, userCredential:\n ' + userCredential.toString());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Exception signInWidthEmail: ' + e.toString());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
