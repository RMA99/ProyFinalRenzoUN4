import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proy_final_renzo/domain/entities/componentes.dart';

class cComponentes {
  Future<String> getPathImage(String imageName) async {
    FirebaseStorage ds = FirebaseStorage.instance;
    String path = await ds.ref(imageName).getDownloadURL();
    return path;
  }

  Future<List<String>> getListID() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var inicio = await db.collection("componentes").get();
    var listID = inicio.docs.map((e) => e.id).toList();
    return listID;
  }

  Future<Componentes> getComponent(String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var inicio =
        await db.collection("componentes").where("modelo", isEqualTo: id).get();
    Map comp_db = inicio.docs.map((e) => e.data()).toList().first;

    Componentes componente = Componentes(
        comp_db["codigo"],
        comp_db["cod_categoria"],
        comp_db["cod_marca"],
        comp_db["modelo"],
        comp_db["detalle"],
        comp_db["estado"],
        comp_db["imagen_path"],
        comp_db["stock"],
        comp_db["precio"]);
    return componente;
  }

  Future<Componentes> getComponentbyCode(String code) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var inicio = await db
        .collection("componentes")
        .where("codigo", isEqualTo: code)
        .get();
    Map comp_db = inicio.docs.map((e) => e.data()).toList().first;

    Componentes componente = Componentes(
        comp_db["codigo"],
        comp_db["cod_categoria"],
        comp_db["cod_marca"],
        comp_db["modelo"],
        comp_db["detalle"],
        comp_db["estado"],
        comp_db["imagen_path"],
        comp_db["stock"],
        comp_db["precio"]);
    return componente;
  }
}
