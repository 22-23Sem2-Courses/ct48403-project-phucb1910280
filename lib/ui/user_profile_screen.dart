import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản', style: TextStyle(fontSize: 25)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
