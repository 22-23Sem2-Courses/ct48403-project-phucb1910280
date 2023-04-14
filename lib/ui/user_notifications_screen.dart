import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/models/notification_provider.dart';
import 'package:provider/provider.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({super.key});

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size.width;
    var notif = Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo (${notif.getNotificationCount().toString()})',
            style: TextStyle(fontSize: s * 0.05)),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('XBusCustomers')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('userNotifications')
            .orderBy('id', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount:
                  snapshot.data!.docs.isEmpty ? 0 : snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(s * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                        color: snapshot.data!.docs[index]['daDoc'] == 'chua'
                            ? Colors.red[50]
                            : Colors.transparent),
                    child: ListTile(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('XBusCustomers')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection('userNotifications')
                            .doc(snapshot.data!.docs[index].id)
                            .update({
                          'daDoc': 'daDoc',
                        }).then((value) {
                          notif.markRead();
                        });
                      },
                      isThreeLine: true,
                      leading: snapshot.data!.docs[index]['daDoc'] == 'chua'
                          ? Icon(
                              Icons.mark_email_unread,
                              color: Colors.red,
                              size: s * 0.05,
                            )
                          : Icon(
                              Icons.mark_email_read_outlined,
                              color: Colors.green,
                              size: s * 0.05,
                            ),
                      title: Text(snapshot.data!.docs[index]['tieuDe'],
                          style: TextStyle(fontSize: s * 0.05)),
                      subtitle: Text(
                        '${snapshot.data!.docs[index]['noiDung']}\n${snapshot.data!.docs[index]['thoiGian']}',
                        style: TextStyle(
                            fontSize: s * 0.04, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
