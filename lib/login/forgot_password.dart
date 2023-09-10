import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth.dart';

class ForgotPassword extends StatelessWidget {
  final emailController = TextEditingController();

/*  Future<void> resetPassword({required email}) async
  {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (exception) {}
  }*/
  Future<void> resetPassword(BuildContext context, {required email}) async {
    try {
      await AuthService().resetPassword(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent successfully')),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'The email address is badly formatted.';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obsecuretext: false,
                ),
                const SizedBox(height: 10),
                MyButton(
                  onTap: () {
                    resetPassword(context, email: emailController.text);
                  },
                  text: 'Reset Password',
                ),
                const SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Navigator.pop(context); // Go back to the login page
                  },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
