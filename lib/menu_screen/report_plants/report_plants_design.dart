import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ident_plant/alert/alert.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/id_plants/id_plants_controller.dart';
import 'package:ident_plant/menu_screen/id_plants/id_plants_model.dart';
import 'package:ident_plant/menu_screen/id_plants/plant_information.dart';
import 'package:ident_plant/menu_screen/id_plants/service_firebase.dart';

class ReportPlantsDesign extends StatefulWidget {
  const ReportPlantsDesign({
    super.key,
  });

  @override
  State<ReportPlantsDesign> createState() => _ReportPlantsDesignState();
}

class _ReportPlantsDesignState extends State<ReportPlantsDesign> {
  IdPlantsController idPlantsController = new IdPlantsController();
  String search = "";
      List<String> paint =[];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primary,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.only(top: 40),
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                hintText: "Buscar...",
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade800),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                print(value);
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: FutureBuilder<List<Report>>(
                  //chincho
                  future: getListPlant(search),
                  builder: (context, value) {
                    if (value.hasData) {
                      return Column(
                        children: List.generate(
                          value.data!.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DescriptionScreen(
                                    urlimage: value.data![index].foto,
                                    name: value.data![index].plant,
                                    level: value.data![index].level,
                                    latitud: value.data![index].latitude
                                            .toString() ??
                                        "",
                                    longitud: value.data![index].longitude
                                            .toString() ??
                                        "",
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              margin: const EdgeInsets.only(top: 10),
                              elevation: 30,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    elevation: 20,
                                    child: Image.network(
                                      value.data![index].foto,
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 170,
                                      loadingBuilder:
                                          (_, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const SizedBox(
                                            height: 120,
                                            width: 170,
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Text(
                                          //mario "${value.data![index].latitude} - ${value.data![index].longitude}",
                                          value.data![index].plant,
                                          // "${value.data![index].latitude }",
                                          style:
                                              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                        ),
                                        
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            
                                            Text(
                                              value.data![index].date,
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          
                                            Text(
                                              value.data![index].time,
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                           
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            
                                              showCupertinoDialog(
                                                context: context, 
                                                builder: ( _ ){
                                                  return CupertinoAlertDialog(
                                                    title: Text('Eliminar'),
                                                    content: Text('Presione el boton aceptar si desea eliminar la planta '+value.data![index].plant+ ', si no, presionar cancelar'),
                                                    actions: [
                                                        CupertinoDialogAction(
                                                          isDestructiveAction: true,
                                                        child: Text('Cancelar'),
                                                        onPressed: ()=>Navigator.pop(context),
                                                        ),
                                                        CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        child: Text('Aceptar'),
                                                        onPressed: ()=>{
                                                         idPlantsController.removeReport(value.data![index].uid,value.data![index].foto),
                                                         Navigator.pop(context),
                                                         setState(() {}),
                                                           Fluttertoast.showToast(
                                                            msg: "Mensaje\nRegistro eliminado correctamente",
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            timeInSecForIosWeb: 3,
                                                            backgroundColor: AppTheme.primary,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0)
                                                        },
                                                        ),
                                                    ],
                                                  );
                                                }
                                              );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 70, top: 50),
                                            child: Icon(Icons.delete, color: Colors.red,size: 30,),
                                          ),
                                        )
                                       
                                      ],
                                      
                                    ),
                                    
                                  ),
                                  
                                ],
                                
                              ),
                              
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
