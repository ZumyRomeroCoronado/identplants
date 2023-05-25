import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ident_plant/alert/alert.dart';
import 'package:ident_plant/button/button.dart';
import 'package:ident_plant/color/app_theme.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primary, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primary, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email, color: AppTheme.primary)),
        ),
        const SizedBox(height: 25),
        Button(
            text: 'Cambiar contraseña',
            onpres: () async {
              FocusScope.of(context).unfocus();
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });

              try {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: _emailController.text.trim());

                AlertScreen.alert('Se envio el correo');
              } on FirebaseAuthException catch (e) {
                AlertScreen.alert('Correo incorrecto');
              }
            })
      ],
    );
  }
}
