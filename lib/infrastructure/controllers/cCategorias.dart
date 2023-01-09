import 'package:cloud_firestore/cloud_firestore.dart';

class cCategorias {
  Future<String> getCode(String categoria) async {
    String codeCat;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("categorias")
        .where("categorias", isEqualTo: categoria)
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
}
