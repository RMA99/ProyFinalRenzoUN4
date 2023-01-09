import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getpersonas() async {
  List personas = [];

  CollectionReference collectionReference = db.collection("personas");
  final val = collectionReference.where("nombre", isEqualTo: "P0002");

  QuerySnapshot queryPersonas = await collectionReference.get();

  queryPersonas.docs.forEach((element) {
    personas.add(element.data());
  });
  //await Future.delayed(const Duration(seconds: 4));

  return personas;
}
/*
Stream<List> prueba() async {
  List nombre1 = [];

  CollectionReference collectionReference = db.collection("personas");
  collectionReference.where("codigo", isEqualTo: "P0002");

  QuerySnapshot queryPersonas = await collectionReference.get();

  nombre1 = queryPersonas.docs;
  //await Future.delayed(const Duration(seconds: 4));

  return nombre1;
}


*/

void search() async {
  List searchResult = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  final result =
      await db.collection("personas").where("codigo", isEqualTo: "P0002").get();
  //final valor = result.docs.map((e) => e.data());
  //final xd = valor['nombre'];
  final asd = result.docs.map((e) => e.data());

  searchResult = result.docs.map((e) => e.data()).toList();
  //final prueba = searchResult.asMap().;
  //prueba["0"];
  print(asd);
  //print(searchResult[0]["nombre"]);
}
