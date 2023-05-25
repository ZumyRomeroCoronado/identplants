/* import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:ident_plant/menu_screen/home/controller_home.dart';

class HomeDesign extends StatefulWidget {
  const HomeDesign({super.key});

  @override
  State<HomeDesign> createState() => _HomeDesignState();
}

class _HomeDesignState extends State<HomeDesign> {
  HomeController homeController = new HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   homeController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primary,
        title: Center(child: const Text('Home')),
      ),
      body: Stack(children: [
        //   _googleMaps(),
      ]),
    );
  }

  Widget _googleMaps() {
    //retornamos googlemap de flutter
    return GoogleMap(
      initialCameraPosition: homeController.inicialPosition,
      mapType: MapType.terrain,
      onMapCreated: homeController.onMapCreate,
      //crea un pequeño punto azul
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(homeController.markers.values),
      onCameraMove: (position) {
        homeController.inicialPosition = position;
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}
 */