

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:incyte/services/auth.dart';


import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import '../register/register.dart';
import '../topics/topics.dart';
import 'forgot_password.dart';


/*
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: AuthService().anonLogin,
                color: Colors.deepPurple,
              ),
            ),
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color: Colors.blue,
              loginMethod: AuthService().googleLogin,
            ),

          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
        required this.text,
        required this.icon,
        required this.color,
        required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
*/





class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // textediting controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


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
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                // welcome
                Text(
                  "Welcome back you've been missed",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                // username textfield
                MyTextField(

                  controller: usernameController,
                  hintText: 'Username',
                  obsecuretext: false,
                ),
                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecuretext: true,
                ),
                const SizedBox(height: 10),

                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // sign in button
                MyButton(

                  onTap: () {
                    signInUser( context,
                        usernameController.text, passwordController.text);
                  }, text: 'Sign in',
                ),

                const SizedBox(height: 50),
                // or continue with
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

                // google  + apple sign in button
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    GestureDetector(
                        child: const SquareTile(imagePath: 'assets/google.png'),
                      onTap: (){
                          AuthService().googleLogin();
                      },
                    ),
                    /*SizedBox(
                      width: 25,
                    ),

                    // apple button
                    SquareTile(imagePath: 'assets/apple.png'),*/
                  ],
                ),
                const SizedBox(height: 20),
                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                     InkWell(
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => RegisterScreen()
                        ));                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// void signInUser(String username, String password) {
//     // Call your sign-in logic using the provided username and password
//     // AuthService().signIn(username, password);
// AuthService().emailLogin(email: username, password: password);
//
//   }
void signInUser(BuildContext context, String username, String password) async {
  try {
    await AuthService().emailLogin(email: username, password: password);
    // Successful login, navigate to the desired screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const TopicsScreen()));
  } on FirebaseAuthException catch (e) {
    String errorMessage = 'The email address is badly formatted.';

    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
}


