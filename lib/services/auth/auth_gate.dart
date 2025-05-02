import 'package:chat_app/pages/homepage.dart';
import 'package:chat_app/services/auth/login_or_register.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged
          if (snapshot.hasData) {
            return  Screen();
          } else {
            return LoginOrRegister();
          }
          //user is not logged
        },
      ),
    );
  }
}
