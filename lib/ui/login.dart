import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

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
                    color: Color(0xffB0F3F1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Email', true, false)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: customeTextField('Mật khẩu', false, hidePassword)),
              const SizedBox(
                height: 20,
              ),
              loginOptionButton('Đăng nhập'),
              const SizedBox(
                height: 60,
                child: Center(
                    child: Text(
                  'Bạn chưa có tài khoản?',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
              loginOptionButton('Đăng ký'),
            ],
          ),
        ),
      ),
    );
  }

  Widget customeTextField(
      String hintText, bool isTestFieldEmail, bool needObscureText) {
    return TextField(
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

  Widget loginOptionButton(String label) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xff96E4DF),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              color: Colors.teal[800]!,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
