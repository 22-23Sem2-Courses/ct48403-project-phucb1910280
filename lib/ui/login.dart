import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/home_page.dart';
import 'package:myproject_app/ui/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pwController.dispose();
  }

  Future login() async {
    try {
      // user login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwController.text.trim());
      // navigation
      if (FirebaseAuth.instance.currentUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: const Text('Sai Email/ Mật khẩu'),
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
              SizedBox(
                width: screenWidth * 0.8,
                child: Image.asset(
                  'assets/images/appLogo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Đăng nhập',
                style: TextStyle(
                    // color: Color(0xffB0F3F1),
                    color: Color(0xffAFF6CF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child:
                      customeTextField('Email', true, false, emailController)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField(
                      'Mật khẩu', false, hidePassword, pwController)),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: loginButton('Đăng nhập')),
              const SizedBox(
                height: 60,
                child: Center(
                    child: Text(
                  'Bạn chưa có tài khoản?',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: registerButton('Đăng ký')),
            ],
          ),
        ),
      ),
    );
  }

  Widget customeTextField(String hintText, bool isTestFieldEmail,
      bool needObscureText, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      obscureText: needObscureText,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          prefixIcon: isTestFieldEmail
              ? const Icon(Icons.email_outlined)
              : const Icon(Icons.lock_outline_rounded),
          suffixIcon: !isTestFieldEmail
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

  Widget loginButton(String label) {
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

  Widget registerButton(String label) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.teal,
        border: Border.all(
          color: const Color(0xffAFF6CF),
          width: 4,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xffAFF6CF),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
