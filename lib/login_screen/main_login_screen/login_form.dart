import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ident_plant/alert/alert.dart';
import 'package:ident_plant/button/button.dart';
import 'package:ident_plant/color/app_theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool passwordVisivility = true;
  // final obcure = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text('Inicio Sesión',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppTheme.primary)),
          const SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primary)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primary, width: 2),
                ),
                hintText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email, color: AppTheme.primary)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: passwordVisivility,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primary)),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primary, width: 2),
              ),
              hintText: 'Contraseña',
              prefixIcon:
                  const Icon(Icons.lock_rounded, color: AppTheme.primary),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisivility ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisivility = !passwordVisivility;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Button(
              text: 'Iniciar',
              onpres: () async {
                final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text);

                if(!emailValid){
                      AlertScreen.alert('Formulario no valido, Debes ingresar un email de correo valido');
                      return;
                }
                 else if(_emailController.text.isEmpty){
                     AlertScreen.alert('Formulario no valido, Debes ingresar el email');
                      return;
                 }else if(_passwordController.text.length<6 || _passwordController.text.length>8){
                     AlertScreen.alert('Formulario no valido, Contraseña debe tener entre 6 ó 8 caracteres');
                     return;
                 }
 


                FocusScope.of(context).unfocus();
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });

                try {
                        
                  UserCredential userCredential =
                      await auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                    password: _passwordController.text,
                  );
                  user = userCredential.user;
                  //if (user != null && context.mounted) {
                     if (user != null && mounted) {
                    Navigator.pushNamed(context, 'menu');
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-email') {
                    AlertScreen.alert('Correo incorrecto');
                  } else if (e.code == 'wrong-password') {
                    AlertScreen.alert('Contraseña incorrecto');
                  } else if (e.code == 'user-nt-found') {
                    AlertScreen.alert('Usuario incorrecto');
                  }
                } catch (e) {
                  AlertScreen.alert('Error de conexion');
                }
              }),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'password');
              },
              child: const Text('¿Olvido contraseña?',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 17,
                      decoration: TextDecoration.underline))),
          const SizedBox(height: 10),
          const Text(
            '¿No tiene cuenta registrada?',
            style: TextStyle(color: AppTheme.primary, fontSize: 15),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registerUser');
              },
              child: const Text('¿registrarse?',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 17,
                      decoration: TextDecoration.underline))),
        ],
      ),
    );
  }
}
