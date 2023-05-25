/* import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/id_plants/id_plants_controller.dart';
import 'package:provider/provider.dart';

class PlantInformation extends StatefulWidget {
  const PlantInformation(
      {super.key,
      this.image,
      this.urlimage = '',
      required this.name,
      required this.level});
  final File? image;
  final String urlimage;
  final String name;
  final double level;

  @override
  State<PlantInformation> createState() => _PlantInformationState();
}

class _PlantInformationState extends State<PlantInformation> {
  final idplantcontroller = IdPlantsController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    getListPlant();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  Future<void> getListPlant() async {
    await context.read<IdPlantsController>().getListPlant();
  }

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
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: 800,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    FutureBuilder(
                        future: idplantcontroller.getListPlant(),
                        builder: (context, value) {
                          if (value.hasData) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(0, 5))
                                  ]),
                              child: widget.urlimage.isEmpty
                                  ? Image.file(
                                      widget.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      widget.urlimage,
                                      fit: BoxFit.cover,
                                    ),
                            );
                          }
                          return Container();
                        }),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(right: 250),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(0, 5))
                          ]),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/logomap.jpg'),
                        iconSize: 50,
                      ),
                    ),
                    const Text('El nombre'),
                    const SizedBox(height: 20),
                    const Text('El nivel de la imagen'),
                    const SizedBox(height: 20),
                    const Text('Descripcion de la planta'),
                    const Text(''),
                    const SizedBox(height: 20),
                    const Text('Nombre cientifico'),
                    const Text(''),
                    const SizedBox(height: 20),
                    const Text('Familia'),
                    const Text(''),
                    const SizedBox(height: 20),
                    const Text('Beneficios'),
                    const Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/home/controller_home.dart';

import 'package:ident_plant/menu_screen/id_plants/plant_information_model.dart';
import 'package:ident_plant/menu_screen/id_plants/service_firebase.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen(
      {super.key,
      this.image,
      this.urlimage = '',
      required this.name,
      required this.level,
      required this.latitud,
      required this.longitud});

  final File? image;
  final String urlimage;
  final String name;
  final double level;
  final String latitud;
  final String longitud;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  HomeController _homeController = new HomeController();
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: const Text('Regresar'),
        ),
        body: FutureBuilder<List<Plant>>(
            future: getplants(widget.name),
            builder: (context, value) {
              if (value.hasData) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Container(
                          width: 300,
                          height: 220,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(0, 5))
                              ]),
                          child: widget.urlimage.isEmpty
                              ? Image.file(
                                  widget.image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.urlimage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        onPressed: () async {
                          validate = await _homeController.validateGPS();
                          if (validate) {
                            if (widget.latitud != "") {
                              Navigator.pushNamed(context, 'location',
                                  arguments: {
                                    'latitud': widget.latitud,
                                    'longitud': widget.longitud
                                  });
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Error interno\nNo se puede mostrar el mapa",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: AppTheme.primary,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Mensaje\nPor favor activar GPS",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: AppTheme.primary,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        icon: Image.asset('assets/logomap.jpg'),
                        iconSize: 80,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.name ?? "",
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                            decoration: TextDecoration.underline),
                      ),
                      const SizedBox(height: 20),
 
                      Text(
                        '${ (widget.level * 100).toStringAsFixed(2)} %',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Descripción de la planta',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: AppTheme.primary),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        value.data!.first.description,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Nombre Cientifico',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: AppTheme.primary),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        value.data!.first.nombrecientifico,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Familia',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: AppTheme.primary),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        value.data!.first.family,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Beneficios',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: AppTheme.primary),
                          textAlign: TextAlign.start),
                      const SizedBox(height: 10),
                      Text(
                        value.data!.first.benefit,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}
