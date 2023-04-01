import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/auth/login.dart';
import 'package:myproject_app/ui/user_profile/edit_user_profile.dart';
import 'package:myproject_app/ui/user_profile/user_profile_detail.dart';

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
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfileDetail()));
            },
            child: customizeText(
              'Thông tin cá nhân',
              const Icon(
                Icons.person_outline,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditUserData()));
            },
            child: customizeText(
              'Chỉnh sửa thông tin',
              const Icon(
                Icons.edit_outlined,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (FirebaseAuth.instance.currentUser == null) {
                if (context.mounted) {}
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              }
            },
            child: customizeText(
              'Đăng xuất',
              const Icon(
                Icons.logout,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customizeText(String label, Icon icon,
      {Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: 20,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 25,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
