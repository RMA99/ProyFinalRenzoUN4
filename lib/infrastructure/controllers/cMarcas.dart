import 'package:cloud_firestore/cloud_firestore.dart';

class cMarcas {
  Future<String> getCode(String marca) async {
    String codeMarca;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista =
        await db.collection("marcas").where("marcas", isEqualTo: marca).get();

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
}
