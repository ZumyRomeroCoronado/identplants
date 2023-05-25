import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'package:ident_plant/menu_screen/id_plants/result.dart';
import 'package:ident_plant/menu_screen/menu_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class IdPlantsController with ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  late File _selectedPicture;
  late String url;
  late Result _result;
  late String namePlant;
  late double levelPercent;
  

  Future pickImage(ImageSource source, context, double lat, double lng) async {
    print(
        '*******************************************************************');
    XFile? pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      //upload(file);
      /*    setState(( ) {
        _selectedPicture = file;
      }); */
      _selectedPicture = file;
      ChangeNotifier();
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.');
      print(lat);
      print(lng);
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.');

      identifyImage(file, context,lat, lng);
    }
  }

  //upload image to firebase storage
  Future upload(
      File image, String name, double level, BuildContext context, double latitude, longitude) async {
    final imageReference = FirebaseStorage.instance.ref().child('ImagePlants');
    final date = DateTime.now();
    final uploadimage =
        imageReference.child(date.toString() + '.png').putFile(image);
    final imageUrl = await (await uploadimage).ref.getDownloadURL();
    saveUrlimage(imageUrl, name, level,latitude,longitude);
    print('............................................................');
    print(imageUrl);
/*     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantInformation(
          urlimage: imageUrl,
          name: _result.label,
          level: _result.confidence,
        ),
      ),
    ); */
  }

  Future saveUrlimage(String url, String name, double level,double latitude, double longitude) async {
    final iduser = FirebaseAuth.instance.currentUser!.uid;

    final bdTimekey = DateTime.now();
    final formatDate = DateFormat('dd/MM/yyyy');
    final formatTime = DateFormat('EEEE,hh:mm aaaa');

    String date = formatDate.format(bdTimekey);
    String time = formatTime.format(bdTimekey);
   var intValue = Random().nextInt(10); // El valor es >= 0 y < 10.
    intValue = Random().nextInt(400000) + 100000; // 
    String uidd=intValue.toString()+iduser;

   FirebaseFirestore.instance.collection("Report").doc(uidd).set(
    {
      'uid':uidd,
      'user': iduser,
      'plantImage': url,
      'date': date,
      'time': time,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'namePlant': name,
      'level': level,
    });


    // FirebaseFirestore.instance.collection('Report').add({
    //   'user': iduser,
    //   'plantImage': url,
    //   'date': date,
    //   'time': time,
    //   'latitude': latitude.toString(),
    //   'longitude': longitude.toString(),
    //   'namePlant': name,
    //   'level': level,
    // });

    
  }

  Future identifyImage(File file, context, lat, lng) async {
    String? _ = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    List? recognitions = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 1,
      imageMean: 128,
      imageStd: 128,
    );
    if (recognitions!.isNotEmpty) {
      //print(recognitions);
      //setState(() {
      _result = Result.fromMap(recognitions.first);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescriptionScreen(
            image: _selectedPicture,
            name: _result.label,
            level: _result.confidence,
            latitud: lat.toString(),
            longitud: lng.toString(),
          ),
        ),
      );
      print(
          '......................................................mmmmmmmmmmmmmmmmmmmm');
      print(_result.label);
      print(_result.confidence);

      // print(_result.confidence);
      upload(file, _result.label, _result.confidence, context, lat, lng);
      //});
    }
    notifyListeners();
  }


  Future<void> removeReport(String uid,String img)async{
        
 
        CollectionReference _ref = FirebaseFirestore.instance.collection('Report');
        _ref.doc(uid).delete();  
    //  final imageReference = FirebaseStorage.instance.ref().child('https://firebasestorage.googleapis.com/v0/b/identplant-f3783.appspot.com/o/ImagePlants%2F2023-05-03%2000%3A30%3A56.131176.png?alt=media&token=e0aeed27-8123-42cd-af98-bd4f83626088');
    // await imageReference.delete();
  }

  // getplants() {}

  /* FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Plant>> getplants(String name) async {
    List plants = [];
    CollectionReference collectionReference = db.collection('plants');
    QuerySnapshot querySnapshot = await collectionReference.get();

    for (var element in querySnapshot.docs) {
      plants.add(
        element.data(),
      );
    }
    final mapresponse = <String, dynamic>{};
    mapresponse['data'] = plants;

    final response = PlantsModele.fromJson(mapresponse);
    final valor =
        response.data.where((element) => element.name == name).toList();
    notifyListeners();
    return valor;
  }

  Future<List<Report>> getListPlant() async {
    List reportes = [];
    CollectionReference collectionReference = db.collection('Report');
    QuerySnapshot querySnapshot = await collectionReference.get();
    // print(querySnapshot.docs);

    for (var element in querySnapshot.docs) {
      reportes.add(
        element.data(),
      );
    }
    final mapresponse = <String, dynamic>{};
    mapresponse['data'] = reportes;
    //print(json.encode(mapresponse));

    final response = ReportModele.fromJson(mapresponse);
    final valor = response.data;
    notifyListeners();

    return valor;
  } */
}
