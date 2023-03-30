import 'package:flutter/material.dart';

class UserTicketsScreen extends StatelessWidget {
  const UserTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé xe của tôi', style: TextStyle(fontSize: 25)),
        elevation: 0,
      ),
    );
  }
}
