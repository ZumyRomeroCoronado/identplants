import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ident_plant/color/app_theme.dart';

  
 class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Add a marker to the map
  void _addMarker(LatLng position, String markerId) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

  final paramts = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  
    double lat = double.parse(paramts["latitud"].toString());
    double lng = double.parse(paramts["longitud"].toString());

    LatLng initialPosition = LatLng(lat, lng); // Initial position for the map
    _addMarker(initialPosition, 'marker1'); // Add a marker to the initial position

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: const Text('Regresar'),
        ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 14,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}