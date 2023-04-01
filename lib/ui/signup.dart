import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/home_page.dart';
import 'package:myproject_app/ui/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hidePassword = true;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var pwController = TextEditingController();
  var pwConfController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    pwController.dispose();
    pwConfController.dispose();
  }

  Future signUp() async {
    try {
      if (checkName() &&
          checkPhoneNumber() &&
          checkEmail() &&
          checkPw() &&
          checkConfPw()) {
        if (confirmedPW()) {
          // create user's account
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: pwController.text.trim());
          // create user's data
          await createUserData(nameController.text, phoneController.text.trim(),
              emailController.text.trim());
          // navigation
          if (FirebaseAuth.instance.currentUser != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false);
          }
        } else {
          showDialog(
            barrierColor: Colors.teal,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: const Text('Mật khẩu không trùng khớp'),
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
        }
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: const Text('Có lỗi xảy ra.\nVui lòng thử lại sau.'),
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
    }
  }

  Future createUserData(
    String userName,
    String userPhoneNumber,
    String userEmail,
  ) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('XBusCustomers');
    return collectionRef
        .doc(currentUser!.email)
        .collection('userData')
        .doc(userEmail)
        .set(
      {
        'id': userEmail,
        'fullName': userName,
        'phoneNumber': userPhoneNumber,
        'email': userEmail,
      },
    );
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

  bool checkEmail() {
    if (!emailController.text.contains('@') ||
        emailController.text.length < 10 ||
        emailController.text.isEmpty) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng nhập email hợp lệ!'),
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

  bool checkPw() {
    if (pwController.text.length < 8 || pwController.text.isEmpty) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Mật khẩu phải dài hơn 8 ký tự'),
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

  bool checkConfPw() {
    if (pwConfController.text.length < 8 || pwConfController.text.isEmpty) {
      showDialog(
        barrierColor: Colors.teal,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Vui lòng xác nhận mật khẩu'),
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

  bool confirmedPW() {
    if (pwConfController.text.trim() == pwController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Đăng ký',
                style: TextStyle(
                    // color: Color(0xffB0F3F1),
                    color: Color(0xffAFF6CF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Họ tên', const Icon(Icons.person),
                      true, false, nameController, TextInputType.text)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField(
                      'Số điện thoại',
                      const Icon(Icons.phone),
                      true,
                      false,
                      phoneController,
                      TextInputType.number)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Email', const Icon(Icons.email),
                      true, false, emailController, TextInputType.text)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Mật khẩu', const Icon(Icons.lock),
                      false, hidePassword, pwController, TextInputType.text)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField(
                      'Xác nhận mật khẩu',
                      const Icon(Icons.lock),
                      true,
                      hidePassword,
                      pwConfController,
                      TextInputType.text)),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  signUp();
                },
                child: customeButton('Đăng ký', true),
              ),
              const SizedBox(
                height: 60,
                child: Center(
                    child: Text(
                  'Bạn đã có tài khoản?',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: customeButton('Đăng nhập', false)),
            ],
          ),
        ),
      ),
    );
  }

  Widget customeTextField(
    String hintText,
    Icon icon,
    bool isNotPassWordTextField,
    bool needObscureText,
    TextEditingController textEditingController,
    TextInputType textInputType,
  ) {
    return TextField(
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: needObscureText,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          prefixIcon: icon
          // isTestFieldEmail ? const Icon(Icons.email_outlined) : null
          ,
          suffixIcon: !isNotPassWordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: hidePassword
                      ? Image.asset(
                          'assets/icons/showPass.png',
                          color: Colors.grey,
                        )
                      : Image.asset('assets/icons/unShowPass.png',
                          color: Colors.grey))
              : null,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          )),
    );
  }

  Widget customeButton(String label, bool isRegisterButton) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color:
              isRegisterButton == true ? Colors.teal : const Color(0xffAFF6CF),
        ),
        color: isRegisterButton == true ? const Color(0xffAFF6CF) : null,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isRegisterButton == true
                ? Colors.teal[800]
                : const Color(0xffAFF6CF),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
