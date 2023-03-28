import 'package:flutter/material.dart';
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
                      true, false, nameController)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Số điện thoại',
                      const Icon(Icons.phone), true, false, phoneController)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Email', const Icon(Icons.email),
                      true, false, emailController)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Mật khẩu', const Icon(Icons.lock),
                      false, hidePassword, pwController)),
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
                      pwConfController)),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    if (checkForm(
                            nameController.text,
                            phoneController.text,
                            emailController.text,
                            pwController.text,
                            pwConfController.text) !=
                        5) {
                      print('Error');
                    } else {
                      print('succed');
                    }
                  },
                  child: customeButton('Đăng ký')),
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
                  child: customeButton('Đăng nhập')),
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
      TextEditingController textEditingController) {
    return TextField(
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

  Widget customeButton(String label) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xffAFF6CF),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.teal[800]!,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  int checkForm(
      String name, String phone, String email, String passWord, String pwConf) {
    int c = 0;
    if (name.length < 10) {
      showDialog(
          barrierColor: Colors.teal,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text('Vui lòng điền họ tên'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      c++;
    }
    if (phone.length < 10 || !phone.startsWith('0')) {
      showDialog(
          barrierColor: Colors.teal,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text('Vui lòng nhập só điện thoại hợp lệ'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      c++;
    }
    if (!email.contains('@') || email.length < 5 || !email.contains('.')) {
      showDialog(
          barrierColor: Colors.teal,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text('Vui lòng nhập địa chỉ email hợp lệ'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      c++;
    }
    if (passWord.length < 8) {
      showDialog(
          barrierColor: Colors.teal,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text('Mật khẩu phải dài hơn 8 ký tự'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      c++;
    }
    if (passWord.compareTo(pwConf) != 0) {
      showDialog(
          barrierColor: Colors.teal,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text('Xác nhận mật khẩu không chính xác'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      c++;
    }
    return c;
  }
}
