import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/home_page.dart';

import '../../shared/popup_change_img_profile.dart';

class EditUserData extends StatefulWidget {
  const EditUserData({super.key});

  @override
  State<EditUserData> createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final imgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    var user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance
        .collection('XBusCustomers')
        .doc(user!.email)
        .collection('userData');
    var docSnapshot = await collection.doc(user.email).get();
    try {
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        setState(() {
          nameController.text = data?['fullName'];
          phoneController.text = data?['phoneNumber'];
          imgController.text = data?['profileImg'];
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateUserData() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('XBusCustomers')
        .doc(user!.email)
        .collection('userData')
        .doc(user.email)
        .update({
      'fullName': nameController.text,
      'phoneNumber': phoneController.text,
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  pageIndex: 3,
                                )),
                        (route) => false);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
    });
  }

  bool checkName() {
    if (nameController.text.isEmpty || nameController.text.length < 5) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng điền họ tên'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool checkPhoneNumber() {
    if (phoneController.text.isEmpty ||
        phoneController.text.length != 10 ||
        !phoneController.text.startsWith('0')) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng nhập số điện thoại hợp lệ'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          customizeTextField('Họ tên:', 'Vui lòng nhập họ tên', nameController,
              TextInputType.text),
          customizeTextField('Số điện thoại:', 'Vui lòng nhập số điện thoại',
              phoneController, TextInputType.number),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: customizeButton('Hủy', false)),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      if (checkName() && checkPhoneNumber()) {
                        updateUserData();
                      }
                    },
                    child: customizeButton('Lưu', true)),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: true,
                          barrierColor: Colors.black45,
                          context: context,
                          builder: (context) {
                            return PopUpChangeImgProfile(
                              imgUrl: imgController.text,
                            );
                          });
                    },
                    child: const Text(
                      'Đổi ảnh đại diện',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customizeTextField(
      String labelText,
      String hintText,
      TextEditingController textEditingController,
      TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: TextField(
        style: const TextStyle(
          fontSize: 22,
        ),
        controller: textEditingController,
        keyboardType: textInputType,
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: const TextStyle(
            color: Colors.teal,
            fontSize: 25,
          ),
          hintText: hintText,
          fillColor: Colors.grey[50],
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
        ),
      ),
    );
  }

  Widget customizeButton(String label, bool isSaveButton) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.teal,
        ),
        color: isSaveButton == true ? Colors.teal : null,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSaveButton == true ? Colors.white : Colors.teal,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
