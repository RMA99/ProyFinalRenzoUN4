import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/categorias.dart';

class cCategorias {
  Future<String> getCode(String categoria) async {
    String codeCat;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("categorias")
        .where("nombre", isEqualTo: categoria)
        .get();

    codeCat =
        lista.docs.map((e) => e.data()).toList().first["codigo"].toString();
    return codeCat;
  }

  Future<String> getCategoria(String code) async {
    String categoria;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("categorias")
        .where("codigo", isEqualTo: code)
        .get();

    categoria =
        lista.docs.map((e) => e.data()).toList().first["nombre"].toString();
    return categoria;
  }

  Future<List<String>> getListCategorias() async {
    List<String> listCategorias = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db.collection("categorias").get();
    lista.docs.map((e) => e.data()).toList().forEach((element) {
      listCategorias.add(element["nombre"]);
    });
    return listCategorias;
  }

  Future<void> actualizar(Categorias categorias) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> newCat;
    newCat = {
      "codigo": categorias.codigo,
      "nombre": categorias.nombre,
    };
    await db.collection("categorias").doc(categorias.nombre).set(newCat);
  }

  Future<void> registrar(Categorias categorias) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");
    final search = await db
        .collection("categorias")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    var codigo = search.map((e) => e.data()).toList().first["codigo"];
    String code = codigo.toString();
    code = "C${formatter.format(int.parse(code.substring(1)) + 1)}";

    Map<String, dynamic> newCat;
    newCat = {
      "codigo": code,
      "nombre": categorias.nombre,
    };
    db.collection("categorias").doc(categorias.nombre).set(newCat);
  }

  Future<void> eliminar(String codigo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var result = await db
        .collection("categorias")
        .where("codigo", isEqualTo: codigo)
        .get();
    String ID = result.docs.map((e) => e.id).first;

    await db.collection("categorias").doc(ID).delete();
  }
}
