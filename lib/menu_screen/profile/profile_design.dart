import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/menu_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileDesign extends StatefulWidget {
  const ProfileDesign({super.key});

  @override
  State<ProfileDesign> createState() => _ProfileDesignState();
}

class _ProfileDesignState extends State<ProfileDesign> {
  final profile = ProfilePhotoController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    getUserData();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  Future<void> getUserData() async {
    await context.read<ProfilePhotoController>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(4, 35, 26, 1),
              Color.fromRGBO(39, 171, 165, 1)
            ],
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(55),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: CircleAvatar(
                        maxRadius: 55,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          //value.data!.foto,
                          context.watch<ProfilePhotoController>().urlImage,
                        ),
                      ),
                    ),
                    /* FutureBuilder(
                        future: profile.getUserData(),
                        builder: (context, value) {
                          if (value.hasData) {
                            return CircleAvatar(
                              maxRadius: 55,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                value.data!.foto,
                                /*  context
                                    .watch<ProfilePhotoController>()
                                    .urlImage, */
                              ),
                            );
                          }
                          return Container();
                        }), */
                    Container(
                      padding: const EdgeInsets.only(left: 65, top: 70),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          elevation: 20,
                          backgroundColor:
                              const Color.fromARGB(255, 30, 146, 152),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Eliger foto de perfil',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              //pickImage(ImageSource.camera);
                                              await context
                                                  .read<
                                                      ProfilePhotoController>()
                                                  .pickImage(
                                                      ImageSource.camera);
                                             // if (context.mounted) {
                                               if (mounted) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            splashColor: Colors.teal,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.camera,
                                                      color: AppTheme.primary),
                                                ),
                                                Text(
                                                  'Camara',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppTheme.primary),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              //pickImage(ImageSource.gallery);
                                              await context
                                                  .read<
                                                      ProfilePhotoController>()
                                                  .pickImage(
                                                      ImageSource.gallery);
                                              //if (context.mounted) {
                                                if (mounted) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            splashColor: Colors.teal,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.image,
                                                      color: AppTheme.primary),
                                                ),
                                                Text(
                                                  'Galeria',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppTheme.primary),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            splashColor: Colors.teal,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                      Icons.remove_circle,
                                                      color: AppTheme.primary),
                                                ),
                                                Text(
                                                  'Cerar',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppTheme.primary),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text('Nomre : ${user?.displayName}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal)),
                const SizedBox(height: 10),
                Text('Correo: ${user?.email}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal)),
                const SizedBox(height: 40),
                Card(
                  elevation: 10,
                  child: ListTile(
                    leading: const Icon(Icons.power_settings_new_rounded,
                        color: Colors.black),
                    title: const Text(
                      'Cerrar Sesion',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      //Navigator.pop(context);
                      if (mounted) {
                     // if (context.mounted) {
                        Navigator.pushNamed(context, 'login');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //enableupload() {}
}
