import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class ErrorMessage extends StatelessWidget {


  const ErrorMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    child: const Text('Access Denied!💀'),
                    onPressed: () async {

                      SnackBarAction(
                        label: 'Log in with your registered email address 🤩',
                        onPressed: () {
                          // Code to execute.
                        },

                      );

                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();

                    },
                  ),
                  // child:  ElevatedButton.icon(
                  //     onPressed: () async {
                  //      await GoogleSignIn().signOut();
                  //
                  //         await FirebaseAuth.instance.signOut();
                  //       },
                  //     label: const Text('logout'),
                  //     icon: const Icon(
                  //       FontAwesomeIcons.iceCream,
                  //     ),
                  //     style: TextButton.styleFrom(
                  //         backgroundColor: Colors.purple
                  //     )
                  // ),

                ]
            )
        )
    );
  }
}


