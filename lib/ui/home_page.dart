import 'package:flutter/material.dart';
import 'package:myproject_app/ui/tickets_overview_screen.dart';
import 'package:myproject_app/ui/user_notifications_screen.dart';
import 'package:myproject_app/ui/user_profile/user_profile_screen.dart';
import 'package:myproject_app/ui/user_tickets_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({int? pageIndex, super.key}) {
    if (pageIndex != null) {
      internalIndex = pageIndex;
    } else {
      internalIndex = 0;
    }
  }

  late final int internalIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  static List<Widget> page = [
    const TicketsOverviewScreen(),
    const UserTicketsScreen(),
    const UserNotifications(),
    const UserProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    pageIndex = widget.internalIndex;
  }

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            context: context,
            builder: (context) {
              return Container(
                height: 320,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          'assets/images/XBus_avt.jpg',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Xe Khách tealXBus',
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.phone,
                                  size: 30,
                                ),
                                label: const Text(
                                  '0919983995 - Mr Phuc',
                                  style: TextStyle(fontSize: 25),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.local_phone),
        label: const Text('Hotline', style: TextStyle(fontSize: 20)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.notifications_none_outlined),
            activeIcon: Icon(
              Icons.notifications,
              color: Colors.teal,
            ),
            label: 'Thông báo',
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
