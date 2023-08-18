
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:incyte/routes.dart';
import 'package:incyte/services/firestore.dart';
import 'package:incyte/services/models.dart';
import 'package:incyte/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  /// Connects to the Cloud
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return const Text('error');
          return const MaterialApp();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (_) => FirestoreService().streamReport(),
            initialData: Report(),
            child: MaterialApp(
              routes: appRoutes,
              theme: appTheme,
            ),
          );
        }

        return const Text(
          'Loading',
          textDirection: TextDirection.ltr,
        );
        // Otherwise, show something whilst waiting for initialization to complete
        // return const Text('loading');
      },
    );
  }
}