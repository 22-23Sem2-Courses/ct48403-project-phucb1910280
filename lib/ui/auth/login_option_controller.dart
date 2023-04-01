import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/auth/login.dart';
import 'package:myproject_app/ui/home_page.dart';

class LoginOptionController extends StatelessWidget {
  const LoginOptionController({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage(
        pageIndex: 0,
      );
    } else {
      return const LoginScreen();
    }
  }
}
