import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
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

  Future<void> actualizar(Componentes componente) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var result = await db
        .collection("componentes")
        .where("codigo", isEqualTo: componente.codigo)
        .get();
    String ID = result.docs.map((e) => e.id).first;

    Map<String, dynamic> newComp;
    newComp = {
      "codigo": componente.codigo,
      "cod_categoria": componente.cod_categoria,
      "cod_marca": componente.cod_marca,
      "modelo": componente.modelo,
      "detalle": componente.detalle,
      "estado": componente.estado,
      "imagen_path": componente.imagen_path,
      "stock": componente.stock,
      "precio": componente.precio,
    };
    await db.collection("componentes").doc(ID).set(newComp);
  }

  Future<void> registrar(Componentes componente) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");
    final search = await db
        .collection("componentes")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    var codigo = search.map((e) => e.data()).toList().first["codigo"];
    String code = codigo.toString();
    code = "CO${formatter.format(int.parse(code.substring(2)) + 1)}";

    var result = await db
        .collection("componentes")
        .where("codigo", isEqualTo: componente.codigo)
        .get();

    Map<String, dynamic> newComp;
    newComp = {
      "codigo": code,
      "cod_categoria": componente.cod_categoria,
      "cod_marca": componente.cod_marca,
      "modelo": componente.modelo,
      "detalle": componente.detalle,
      "estado": componente.estado,
      "imagen_path": componente.imagen_path,
      "stock": componente.stock,
      "precio": componente.precio,
    };
    await db.collection("componentes").doc(componente.modelo).set(newComp);
  }

  Future<void> eliminar(String codigo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var result = await db
        .collection("componentes")
        .where("codigo", isEqualTo: codigo)
        .get();
    String ID = result.docs.map((e) => e.id).first;

    await db.collection("componentes").doc(ID).delete();
  }
}
