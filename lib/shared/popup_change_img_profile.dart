import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/models/list_user_profile_img_url.dart';
import 'package:myproject_app/ui/home_page.dart';

class PopUpChangeImgProfile extends StatefulWidget {
  final String imgUrl;
  const PopUpChangeImgProfile({super.key, required this.imgUrl});

  @override
  State<PopUpChangeImgProfile> createState() => _PopUpChangeImgProfileState();
}

class _PopUpChangeImgProfileState extends State<PopUpChangeImgProfile> {
  String _imgUrl = '';
  int curInd = -1;

  @override
  void initState() {
    super.initState();
    _imgUrl = widget.imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size.width;
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(s * 0.05))),
      content: SizedBox(
        height: s * 0.9,
        width: s * 0.7,
        child: Column(
          children: [
            CircleAvatar(
              radius: s * 0.2,
              backgroundImage: NetworkImage(_imgUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: s * 0.44,
              width: s * 0.55,
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
                            curInd = index;
                            _imgUrl = ListUserProfileImgURL
                                .listUserProfileImgURL[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(150)),
                            border: Border.all(
                              color: Colors.teal,
                              width: index == curInd ? 5 : 0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(ListUserProfileImgURL
                                .listUserProfileImgURL[index]),
                          ),
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
          child: Text(
            'Hủy',
            style: TextStyle(fontSize: s * 0.045),
          ),
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
                    content: Text(
                      'Cập nhật thành công!',
                      style: TextStyle(fontSize: s * 0.05),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(fontSize: s * 0.04),
                          )),
                    ],
                  );
                },
              ).then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              pageIndex: 3,
                            )),
                    (route) => false);
              });
            });
          },
          child: Text(
            'Lưu',
            style: TextStyle(fontSize: s * 0.045),
          ),
        ),
      ],
    );
  }
}
