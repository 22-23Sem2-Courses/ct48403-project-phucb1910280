import 'package:flutter/material.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({super.key});

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo (0)', style: TextStyle(fontSize: 25)),
        elevation: 0,
      ),
    );
  }
}
