import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/auth/login_option_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xe khách X',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const LoginOptionController(),
    );
  }
}
