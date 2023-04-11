import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('XBusCustomers')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('userData')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.teal[50],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(snapshot
                                  .data!.docs[0]['profileImg']
                                  .toString()),
                            ),
                          ),
                        ),
                        title: Text(
                          snapshot.data!.docs[0]['fullName'].toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'tealXBus version v0.1.1',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
