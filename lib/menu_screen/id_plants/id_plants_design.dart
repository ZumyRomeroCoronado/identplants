import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/home/controller_home.dart';
import 'package:ident_plant/menu_screen/id_plants/id_plants_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class IdPlantDesign extends StatefulWidget {
  const IdPlantDesign({super.key});

  @override
  State<IdPlantDesign> createState() => _IdPlantDesignState();
}

class _IdPlantDesignState extends State<IdPlantDesign> {
  HomeController homeController = new HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(4, 35, 26, 1),
              Color.fromRGBO(39, 171, 165, 1)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 120),
                child: Image.asset('assets/logo.gif', scale: 2),
              ),
              const SizedBox(height: 90),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: IconButton(
                    onPressed: () async {
                      bool aux = await homeController.validateGPS();
                      if (aux) {
                        await context.read<IdPlantsController>().pickImage(
                            ImageSource.camera,
                            context,
                            homeController.position!.latitude,
                            homeController.position!.longitude);
                        /*  if (context.mounted) {
                          Navigator.pop(context);
                        } */
                      }
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppTheme.primary,
                      size: 80,
                    )),
              ),
              const SizedBox(height: 50),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: IconButton(
                    onPressed: () async {
                      bool aux = await homeController.validateGPS();
                      if (aux) {
                        await context.read<IdPlantsController>().pickImage(
                            ImageSource.gallery,
                            context,
                            homeController.position!.latitude,
                            homeController.position!.longitude);
                        /*   if (context.mounted) {
                        Navigator.pop(context);
                      } */
                      }
                    },
                    icon: const Icon(
                      Icons.photo_size_select_actual_rounded,
                      color: AppTheme.primary,
                      size: 80,
                    )),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
