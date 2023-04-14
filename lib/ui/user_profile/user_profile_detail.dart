import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/user_profile/edit_user_profile.dart';

class UserProfileDetail extends StatelessWidget {
  const UserProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Thông tin của tôi',
          style: TextStyle(fontSize: s * 0.05),
        ),
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
                userAvatar(
                    snapshot.data!.docs[0]['profileImg'].toString(), context),
                const SizedBox(
                  height: 20,
                ),
                userDetail('Họ tên:',
                    snapshot.data!.docs[0]['fullName'].toString(), context),
                userDetail('Số điện thoại:',
                    snapshot.data!.docs[0]['phoneNumber'].toString(), context),
                userDetail(
                  'Email:',
                  snapshot.data!.docs[0]['email'].toString(),
                  context,
                )
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
          child: editProfileButton(context)),
    );
  }

  Widget userDetail(String label, String value, BuildContext context) {
    var s = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(s * 0.05, 8, 20, 8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: s * 0.05),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.teal, fontSize: s * 0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget editProfileButton(BuildContext context) {
    var s = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      height: s * 0.13,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.teal,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(90)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.edit,
          color: Colors.teal,
          size: s * 0.05,
        ),
        SizedBox(
          width: s * 0.02,
        ),
        Text(
          'Chỉnh sửa thông tin',
          style: TextStyle(
            color: Colors.teal,
            fontSize: s * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  Widget userAvatar(String userImgURL, BuildContext context) {
    var s = MediaQuery.of(context).size.width;

    return Container(
      height: s * 0.6,
      width: s * 0.6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(userImgURL),
        ),
      ),
    );
  }
}
