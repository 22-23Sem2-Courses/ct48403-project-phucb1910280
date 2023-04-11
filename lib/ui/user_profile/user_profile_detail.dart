import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/user_profile/edit_user_profile.dart';

class UserProfileDetail extends StatelessWidget {
  const UserProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Thông tin của tôi'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('XBusCustomers')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('userData')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                userAvatar(snapshot.data!.docs[0]['profileImg'].toString()),
                const SizedBox(
                  height: 20,
                ),
                userDetail(
                    'Họ tên:', snapshot.data!.docs[0]['fullName'].toString()),
                userDetail('Số điện thoại:',
                    snapshot.data!.docs[0]['phoneNumber'].toString()),
                userDetail(
                    'Email:', snapshot.data!.docs[0]['email'].toString()),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EditUserData()));
          },
          child: editProfileButton()),
    );
  }

  Widget userDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 22),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(color: Colors.teal, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget editProfileButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.teal,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Icon(
          Icons.edit,
          color: Colors.teal,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          'Chỉnh sửa thông tin',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  Widget userAvatar(String userImgURL) {
    return Container(
      height: 260,
      width: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(userImgURL),
        ),
      ),
    );
  }
}
