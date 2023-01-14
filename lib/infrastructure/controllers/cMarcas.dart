import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/marcas.dart';

class cMarcas {
  Future<String> getCode(String marca) async {
    String codeMarca;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista =
        await db.collection("marcas").where("nombre", isEqualTo: marca).get();

    codeMarca =
        lista.docs.map((e) => e.data()).toList().first["codigo"].toString();
    return codeMarca;
  }

  Future<String> getMarcas(String codigo) async {
    String marca;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista =
        await db.collection("marcas").where("codigo", isEqualTo: codigo).get();

    marca = lista.docs.map((e) => e.data()).toList().first["nombre"].toString();
    return marca;
  }

  Future<List<String>> getListMarcas() async {
    List<String> listMarcas = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db.collection("marcas").get();
    lista.docs.map((e) => e.data()).toList().forEach((element) {
      listMarcas.add(element["nombre"]);
    });
    return listMarcas;
  }

  Future<void> actualizar(Marcas marcas) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> newMar;
    newMar = {
      "codigo": marcas.codigo,
      "nombre": marcas.nombre,
    };
    await db.collection("marcas").doc(marcas.nombre).set(newMar);
  }

  Future<void> registrar(Marcas marcas) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");
    final search = await db
        .collection("marcas")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    var codigo = search.map((e) => e.data()).toList().first["codigo"];
    String code = codigo.toString();
    code = "M${formatter.format(int.parse(code.substring(1)) + 1)}";

    Map<String, dynamic> newMar;
    newMar = {
      "codigo": code,
      "nombre": marcas.nombre,
    };
    db.collection("marcas").doc(marcas.nombre).set(newMar);
  }

  Future<void> eliminar(String codigo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var result =
        await db.collection("marcas").where("codigo", isEqualTo: codigo).get();
    String ID = result.docs.map((e) => e.id).first;

    await db.collection("marcas").doc(ID).delete();
  }
}
