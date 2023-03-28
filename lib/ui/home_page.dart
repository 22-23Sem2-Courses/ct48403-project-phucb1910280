import 'package:flutter/material.dart';
import 'package:myproject_app/ui/ticket_overview_screen.dart';
import 'package:myproject_app/ui/user_profile_screen.dart';
import 'package:myproject_app/ui/user_ticket_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  static const List<Widget> page = [
    TicketOverviewScreen(),
    UserTicketScreen(),
    UserProfileScreen(),
  ];

  void _changePageIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePageIndex,
        currentIndex: pageIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(
              Icons.home,
              color: Colors.teal,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            activeIcon: Icon(
              Icons.confirmation_number_rounded,
              color: Colors.teal,
            ),
            label: 'Vé xe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(
              Icons.person,
              color: Colors.teal,
            ),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
