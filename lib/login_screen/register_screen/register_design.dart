import 'package:flutter/material.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/login_screen/login_screen.dart';

class RegisterDesign extends StatelessWidget {
  const RegisterDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: const Text('Regresar'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(4, 35, 26, 1),
              Color.fromRGBO(39, 171, 165, 1)
            ],
          )),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                width: double.infinity,
                height: 510,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: const RegisterForm(),
              ),
              const SizedBox(height: 60),
            ],
          )),
        ));
  }
}
