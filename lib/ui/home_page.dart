import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/tickets_overview_screen.dart';
import 'package:myproject_app/ui/user_notifications_screen.dart';
import 'package:myproject_app/ui/user_profile/user_profile_screen.dart';
import 'package:myproject_app/ui/user_tickets_screen.dart';
import 'package:provider/provider.dart';

import '../models/notification_provider.dart';

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
    loadUserData();
  }

  void _changePageIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void loadUserData() async {
    var notificationsCounter =
        Provider.of<NotificationProvider>(context, listen: false);
    if (FirebaseAuth.instance.currentUser != null) {
      await notificationsCounter.loadUserNotificationCount();
    } else {
      await notificationsCounter.resetUserNotificationCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    var notif = Provider.of<NotificationProvider>(context);
    var s = MediaQuery.of(context).size.width;
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
                height: s * 0.6,
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
                      CircleAvatar(
                        radius: s * 0.15,
                        backgroundImage: const AssetImage(
                          'assets/images/XBus_avt.jpg',
                        ),
                      ),
                      SizedBox(
                        height: s * 0.045,
                      ),
                      Text(
                        'Xe Khách tealXBus',
                        style: TextStyle(fontSize: s * 0.05),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.phone,
                                  size: s * 0.035,
                                ),
                                label: Text(
                                  '0919983995 - Mr Phuc',
                                  style: TextStyle(fontSize: s * 0.05),
                                )),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.local_phone,
          size: s * 0.04,
        ),
        label: Text('Hotline', style: TextStyle(fontSize: s * 0.04)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _changePageIndex,
        currentIndex: pageIndex,
        elevation: 0,
        iconSize: s * 0.05,
        selectedFontSize: s * 0.035,
        unselectedFontSize: s * 0.03,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(
              Icons.home,
              color: Colors.teal,
            ),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            activeIcon: Icon(
              Icons.confirmation_number_rounded,
              color: Colors.teal,
            ),
            label: 'Vé xe',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              largeSize: s * 0.035,
              textStyle: TextStyle(
                fontSize: s * 0.026,
              ),
              alignment: AlignmentDirectional(s * 0.03, -s * 0.01),
              label: notif.getNotificationCount() != 0
                  ? Text(notif.getNotificationCount().toString())
                  : const Text(''),
              backgroundColor: notif.getNotificationCount() != 0
                  ? Colors.teal
                  : Colors.transparent,
              textColor: notif.getNotificationCount() != 0
                  ? Colors.white
                  : Colors.transparent,
              child: const Icon(Icons.notifications_none),
            ),
            activeIcon: const Icon(
              Icons.notifications,
              color: Colors.teal,
            ),
            label: 'Thông báo',
          ),
          const BottomNavigationBarItem(
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
