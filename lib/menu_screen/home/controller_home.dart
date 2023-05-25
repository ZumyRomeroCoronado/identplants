import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ident_plant/color/app_theme.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

class HomeController {
  CameraPosition inicialPosition =
      CameraPosition(target: LatLng(6.287079, -75.582827), zoom: 15);
  Function? refresh;

  Completer<GoogleMapController> mapController = Completer();
  Position? position;
  BitmapDescriptor? markersPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future init(BuildContext context, Function refresh) async {
    this.refresh = refresh;
    markersPosition =
        await createMarcadorDeLosAsset('assets/my_location_mini.png');
    verificarGPS();
  }

  void verificarGPS() async {
    bool isLocationEnable = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnable == true) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS == true) {
        updateLocation();
      }
    }
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition();
      animateCameraPosition(position!.latitude, position!.longitude);
      String addres = await address();

      addMarker('Posición actual', position!.latitude, position!.longitude,
          '${addres}', '', markersPosition!);
    } catch (e) {
      print('errorr==>>$e');
    }
  }

  Future<String> address() async {
    List<Placemark> address =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    String direction = address[0].thoroughfare ?? '';
    String calle = address[0].subThoroughfare ?? '';
    String city = address[0].locality ?? '';
    String departamento = address[0].administrativeArea ?? '';
    String country = address[0].country ?? '';

    String addresss = '$direction #$calle , $city, $departamento, $country';

    return addresss;
  }

  Future animateCameraPosition(double lat, double lgt) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lgt), zoom: 14, bearing: 0),
      ),
    );
  }

  void addMarker(String markerId, double lat, double lng, String title,
      String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: iconMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content),
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5, 0.5),
      // rotation: _position.heading
    );

    markers[id] = marker;
    refresh!();
  }

  Future<BitmapDescriptor> createMarcadorDeLosAsset(String url) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor =
        await BitmapDescriptor.fromAssetImage(configuration, url);

    return descriptor;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    //nos devuelve un geolocator con la posicion actual donde nos encontramos
    return await Geolocator.getCurrentPosition();
  }

  void onMapCreate(GoogleMapController controller) {
    //inicializamos
    mapController.complete(controller);
  }

  Future<bool> validateGPS() async {
    bool isLocationEnable = await Geolocator.isLocationServiceEnabled();
    updateLocation();

    if (isLocationEnable == true) {
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS == true) {
        updateLocation();

        Fluttertoast.showToast(
            msg: "Capture la imagen que desea analizar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromARGB(255, 100, 106, 19),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return isLocationEnable;
  }
}
