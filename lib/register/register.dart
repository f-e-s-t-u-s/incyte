import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incyte/services/auth.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class RegisterScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  void signUpUser(BuildContext context, String username, String password) async {
    if (_validateInputs(username, password)) {
      try {
        await AuthService().emailSignUp(email: username, password: password);
        await AuthService().emailLogin(email: username, password: password);
        Navigator.pop(context); // Close the register screen
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred during registration.';

        if (e.code == 'email-already-in-use') {
          errorMessage = 'The email address is already in use.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid email and password')),
      );
    }
  }


  bool _validateInputs(String email, String password) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email) && password.length >= 6;
  }



  void _showPasswordRequirements(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Password Requirements"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("- At least 6 characters long"),
              Text("- Contains both letters and numbers"),
              Text("- Special characters are recommended"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
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
                  Icons.person_add,
                  size: 100,
                ),
                Text(
                  "Create a new account",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obsecuretext: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecuretext: true,
                ),
                const SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         "Password requirements...",
                //         style: TextStyle(
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showPasswordRequirements(context);
                        },
                        child: Text(
                          "Password requirements...",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                MyButton(
                  onTap: () {
                    signUpUser(context, usernameController.text, passwordController.text);
                  }, text: 'Sign up',
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const SquareTile(imagePath: 'assets/google.png'),
                      onTap: (){
                        AuthService().googleLogin().then((value) => Navigator.pop(context));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context); // Go back to the login page
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }

  // void signUpUser(String username, String password) {
  //   // Call your sign-up logic using the provided username and password
  //   AuthService().emailSignUp(email: username, password: password);
  // }

  // void signUpUser(BuildContext context, String username, String password) {
  //   AuthService().emailSignUp(email: username, password: password).then((_) {
  //     // After successful registration, navigate back to the login page
  //     Navigator.pop(context);
  //
  //     // Then initiate the email login process
  //     AuthService().emailLogin(email: username, password: password);
  //   });
  // }


}
