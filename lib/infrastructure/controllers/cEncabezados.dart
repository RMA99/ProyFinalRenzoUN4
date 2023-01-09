import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';

class cEncabezados {
  Future<String> createEncabezado(
      String cod_persona, String direccion, String tipoPago) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");
    var fecha = DateTime.now();

    final search = await db
        .collection("encabezados")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);

    if (search.isEmpty) {
      Map<String, dynamic> newEnca;
      newEnca = {
        "codigo": "CE00001",
        "cod_persona": cod_persona,
        "direccion": direccion,
        "fecha_compra": fecha,
        "fecha_confirmacion": "",
        "fecha_entrega": "",
        "cod_tipo_pago": tipoPago,
      };
      await db.collection("encabezados").add(newEnca);
      return "CE00001";
    } else {
      var codigo = search.map((e) => e.data()).toList().first["codigo"];
      String code = codigo.toString();
      code = "EC${formatter.format(int.parse(code.substring(2)) + 1)}";

      Map<String, dynamic> newEnca;
      newEnca = {
        "codigo": code,
        "cod_persona": cod_persona,
        "direccion": direccion,
        "fecha_compra": fecha,
        "fecha_confirmacion": "",
        "fecha_entrega": "",
        "cod_tipo_pago": tipoPago,
      };
      await db.collection("encabezados").add(newEnca);
      return code;
    }
  }
}
