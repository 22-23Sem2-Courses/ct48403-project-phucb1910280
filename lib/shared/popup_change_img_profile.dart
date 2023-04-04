import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/models/list_user_profile_img_url.dart';

class PopUpChangeImgProfile extends StatefulWidget {
  final String imgUrl;
  const PopUpChangeImgProfile({super.key, required this.imgUrl});

  @override
  State<PopUpChangeImgProfile> createState() => _PopUpChangeImgProfileState();
}

class _PopUpChangeImgProfileState extends State<PopUpChangeImgProfile> {
  String _imgUrl = '';

  @override
  void initState() {
    super.initState();
    _imgUrl = widget.imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 400,
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(_imgUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 180,
              width: 300,
              child: GridView.builder(
                itemCount: ListUserProfileImgURL.listUserProfileImgURL.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 50,
                    width: 50,
                    child: InkWell(
                        focusColor: Colors.teal,
                        onTap: () {
                          setState(() {
                            _imgUrl = ListUserProfileImgURL
                                .listUserProfileImgURL[index];
                          });
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(ListUserProfileImgURL
                              .listUserProfileImgURL[index]),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () async {
            var user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance
                .collection('XBusCustomers')
                .doc(user!.email)
                .collection('userData')
                .doc(user.email)
                .update({
              'profileImg': _imgUrl,
            }).then((value) {
              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black45,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    content: const Text('Cập nhật thành công!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK')),
                    ],
                  );
                },
              ).then((value) {
                Navigator.pop(context);
              });
            });
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
