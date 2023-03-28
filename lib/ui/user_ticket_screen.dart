import 'package:flutter/material.dart';

class UserTicketScreen extends StatelessWidget {
  const UserTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé xe của tôi'),
        elevation: 0,
      ),
    );
  }
}
