import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ident_plant/menu_screen/profile/profile_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoController with ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  late File _selectedPicture;
  String urlImage = '';

  Future pickImage(ImageSource source) async {
    XFile? pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      _selectedPicture = file;
      upload(file);
      /*    setState(() {
        _selectedPicture = file;
      }); */
      // identifyImage(file);

      ChangeNotifier();
      // upload(_selectedPicture);
    }
  }

  Future upload(File image) async {
    final imageReference =
        FirebaseStorage.instance.ref().child('ProfileImages');
    final timekey = DateTime.now(); // get date and time

    final uploadimage =
        imageReference.child(timekey.toString() + '.png').putFile(image);
    final imageUrl = await (await uploadimage).ref.getDownloadURL();
    saveUrlimage(imageUrl);
  }

  Future saveUrlimage(String url) async {
    final iduser = FirebaseAuth.instance.currentUser!.uid;

    // guarda en la base de datos  la url en user.
    await FirebaseFirestore.instance.collection('Users').doc(iduser).update({
      'foto': url,
    });
    getUserData();
  }

  Future<Users> getUserData() async {
    final iduser = FirebaseAuth.instance.currentUser!.uid;
    final resul =
        await FirebaseFirestore.instance.collection('Users').doc(iduser).get();
    final mapresponse = <String, dynamic>{};
    mapresponse['Users'] = resul.data();
    // print('************************************');
    //print(mapresponse);
    final response = ProfileModel.fromJson(mapresponse);
    urlImage = response.users.foto;
    //print('-----------------------------------------');
    //print(urlImage);
    notifyListeners();
    return response.users;
  }
}
