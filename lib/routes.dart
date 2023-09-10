import 'package:incyte/home/home.dart';
import 'package:incyte/login/forgot_password.dart';
import 'package:incyte/login/login.dart';
import 'package:incyte/profile/profile.dart';
import 'package:incyte/register/register.dart';
import 'package:incyte/report/report.dart';
import 'package:incyte/report/report_screen.dart';


var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/topics': (context) =>  MyApp(),
  '/login': (context) => LoginPage(),
  '/report': (context) => const ReportScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/register': (context) => RegisterScreen(),
  '/forgot_password': (context) => ForgotPassword(),
};
