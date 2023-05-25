import 'package:flutter/material.dart';
import 'package:ident_plant/alert/alert.dart';
import 'package:ident_plant/firebase_options.dart';
import 'package:ident_plant/login_screen/login_screen.dart';

import 'package:ident_plant/menu_screen/menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //The multiProvider is to communicate data betowen the pages from enywhere
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProfilePhotoController(),
          ),
          ChangeNotifierProvider(
            create: (_) => IdPlantsController(),
          ),
        ],
        child: MaterialApp(
          title: 'IdentPlant',
          debugShowCheckedModeBanner: false,
          initialRoute: 'login',
          scaffoldMessengerKey: AlertScreen.snackBarKey,
          routes: {
            'login': (_) => const LoginDesign(),
            'password': (_) => const PasswordDesign(),
            'registerUser': (_) => const RegisterDesign(),
            'menu': (_) => const MenuDesign(),
            'profile': (_) => const ProfileDesign(),
            'idplants': (_) => const IdPlantDesign(),
            'location': (_) =>  LocationScreen(),
          },
        ));
  }
}
