import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // Call your AuthService.createUserWithEmailAndPassword(email, password) function here
    // For example:
    // AuthService.createUserWithEmailAndPassword(email, password);

    // You can also navigate to the next screen or perform other actions here
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            // ... Your other widgets ...

            TextFormField(
              controller: _emailController, // Bind the controller
              style: FxTextStyle.bodyLarge(
                  letterSpacing: 0.1, color: themeData.colorScheme.onBackground),
              decoration: InputDecoration(
                hintText: "Email",
                // ... Other decoration properties ...
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: _passwordController, // Bind the controller
                style: FxTextStyle.bodyLarge(
                    letterSpacing: 0.1, color: themeData.colorScheme.onBackground),
                decoration: InputDecoration(
                  hintText: "Password",
                  // ... Other decoration properties ...
                ),
                obscureText: _passwordVisible,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: FxButton(
                elevation: 0,
                borderRadiusAll: 4,
                onPressed: _handleSignUp, // Call the signup function
                child: FxText.labelMedium("LOGIN",
                    fontWeight: 600,
                    color: themeData.colorScheme.onPrimary,
                    letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
