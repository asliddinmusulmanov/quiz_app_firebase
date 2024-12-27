import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/pages/menu/menu.dart';
import 'package:app_quiz/pages/sign/splash_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // stream: AuthService.auth.authStateChanges(),
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? MenuPage(
                user: snapshot.data,
              )
            : const SplashPages();
      },
    );
  }
}
