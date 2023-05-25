import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:ident_plant/menu_screen/id_plants/id_plants_model.dart';
import 'package:ident_plant/menu_screen/id_plants/plant_information_model.dart';

/* class ServiceController with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Report> newreport = [];

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
    print(querySnapshot.docs);

    for (var element in querySnapshot.docs) {
      reportes.add(
        element.data(),
      );
    }
    final mapresponse = <String, dynamic>{};
    mapresponse['data'] = reportes;
    print(
        'jhon hola......................................................__________________________');
    print(json.encode(mapresponse));

    final response = ReportModele.fromJson(mapresponse);
    newreport = response.data;
    notifyListeners();
    return newreport;
  }
}
 */

FirebaseFirestore db = FirebaseFirestore.instance;

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
    String parametro = removeDiacritics(name).toLowerCase();

  final response = PlantsModele.fromJson(mapresponse);
  final valor = response.data.where((element) => removeDiacritics(element.name).toLowerCase()  == parametro).toList();
  return valor;
}






Future<List<Report>> getListPlant(String search) async {

 
  List reportes = [];
  CollectionReference collectionReference = db.collection('Report');
  QuerySnapshot querySnapshot;
  if(search.isEmpty){

     querySnapshot = await collectionReference.get();

  }else{
    
     querySnapshot = await collectionReference.where('namePlant', isEqualTo: search).get();

  }

//chincho 

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
  return valor;
}

  //   void search(String nameplant) async {
      
  //       CollectionReference collectionReference = db.collection('Report');
  //     QuerySnapshot querySnapshot = await collectionReference.where('nameplant', isGreaterThanOrEqualTo:
  //     nameplant)
  //         .where('nameplant', isLessThan: nameplant + 'z')
  //         .get();


  //          for (var element in querySnapshot.docs) {

  //    print( element.data());
  // }

  //   }


        // Método para realizar la consulta de filtrado por nombre
    Future<QuerySnapshot> searchByName(String nameplant) async {
              CollectionReference collectionReference = db.collection('Report');

      return await collectionReference
          .get();
    }

   


