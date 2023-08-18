import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:incyte/services/auth.dart';
import 'package:provider/provider.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var report = Provider.of <Report>(context);
    var user = AuthService().user;


    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? 'Guest'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        user.photoURL ?? 'https://en.gravatar.com/avatar/placeholder'
                    ),
                  ),
                ),
              ),
              Text(user.email ?? '', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              // Text('${report.total}', style: Theme.of(context).textTheme.displayMedium),
              Text('Quizzes Completed' , style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                    Navigator.pushReplacementNamed(context, '/');
                    // await AuthService().signOut();
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    //   ModalRoute.withName('/'),);

                  },
                  label: const Text('logout'),
                  icon: const Icon(
                    FontAwesomeIcons.iceCream,
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.purple
                  )
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    }else{
      return const Text('hello');
    }
  }
}

