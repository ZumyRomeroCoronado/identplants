import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ident_plant/alert/alert.dart';
import 'package:ident_plant/button/button.dart';
import 'package:ident_plant/color/app_theme.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool passwordVisivility = true;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextFormField(
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Campo obligatorio'
                    : null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.primary, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primary, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Registrar Usuario',
                  prefixIcon: Icon(Icons.person, color: AppTheme.primary)),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Campo obligatorio'
                    : null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.primary, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primary, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Registrar correo electrónico',
                  prefixIcon: Icon(Icons.email, color: AppTheme.primary)),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Campo obligatorio'
                    : null;
              },
              obscureText: passwordVisivility,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primary, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primary, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: 'Registrar contraseña',
                prefixIcon:
                    const Icon(Icons.lock_rounded, color: AppTheme.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisivility
                        ? Icons.visibility_off
                        : Icons.visibility,
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
            const SizedBox(height: 25),
            Button(
                text: 'Registrar',
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
                  if (formkey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                  }
                  try {
                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                    final iduser = FirebaseAuth.instance.currentUser!.uid;
                    //print(iduser);
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(iduser)
                        .set({
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'name': _nameController.text,
                    });
                    user = userCredential.user;
                    await user!.updateDisplayName(_nameController.text);
                    await user!.reload();
                    user = auth.currentUser;
                  //  if (user != null && context.mounted) {
                    if (user != null && mounted) {
                      Navigator.pushNamed(context, 'login');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      AlertScreen.alert('La contraseña es muy debil');
                    } else if (e.code == 'email-already-in-use') {
                      AlertScreen.alert('La cuenta existe');
                    } else if (e.code == 'invalid-email') {
                      AlertScreen.alert('Correo incorrecto');
                    }
                  } catch (e) {
                    AlertScreen.alert(' Problema de conexion');
                  }
                })
          ],
        ),
      ),
    );
  }
}
