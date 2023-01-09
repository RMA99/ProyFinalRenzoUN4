import 'package:cloud_firestore/cloud_firestore.dart';

class cTipoPago {
  Future<List<String>> getListTipoPago() async {
    List<String> listTipoPago = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db.collection("tipos_pago").get();
    lista.docs.map((e) => e.data()).toList().forEach((element) {
      listTipoPago.add(element["tipos_pago"]);
    });
    return listTipoPago;
  }

  Future<String> getCode(String tipoPago) async {
    String codeTPago;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("tipos_pago")
        .where("nombre", isEqualTo: tipoPago)
        .get();

    codeTPago =
        lista.docs.map((e) => e.data()).toList().first["codigo"].toString();
    return codeTPago;
  }
}
