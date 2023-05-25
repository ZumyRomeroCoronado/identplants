import 'package:flutter/material.dart';
import 'package:ident_plant/login_screen/login_screen.dart';

class LoginDesign extends StatelessWidget {
  const LoginDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color.fromRGBO(4, 35, 26, 1), Color.fromRGBO(39, 171, 165, 1)],
      )),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 90),
            child: Image.asset('assets/logo.gif', scale: 2),
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            width: double.infinity,
            height: 510,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 10, offset: Offset(0, 5))
                ]),
            child: const LoginForm(),
          ),
          const SizedBox(height: 40),
        ],
      )),
    ));
  }
}
