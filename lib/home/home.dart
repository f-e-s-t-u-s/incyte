import 'package:flutter/material.dart';
import 'package:incyte/topics/topics.dart';
import 'package:incyte/login/login.dart';
import 'package:incyte/services/auth.dart';

import '../test.dart';
/***
 *
 * Home Screen Check auth state logged in or out
 */
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('error'),
          );
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
