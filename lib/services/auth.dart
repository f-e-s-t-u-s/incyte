import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {
  //ASYNCHRONOUS Stream to Notify about changes to the user's sign-in state (such as sign-in or sign-out) to the UI but time of happening you dont know
  final userStream = FirebaseAuth.instance.authStateChanges();
  //Synchronous to check event if user is authentication state in maybe when clicking a button
  final user = FirebaseAuth.instance.currentUser;




  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (exception) {}
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);

    } on FirebaseAuthException catch (exception) {}
  }

  Future<void> emailLogin({required email , required password, }) async
  {

    try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (exception) {
      rethrow;
    }
  }

  Future<void> emailSignUp({required email , required password, }) async
  {

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (exception) {
      rethrow;
    }
  }

  Future<void> resetPassword({required email}) async
  {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (exception) {
      rethrow;
    }
  }

}





