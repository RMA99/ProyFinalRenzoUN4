import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/detTotalCompra.dart';

class cDetTotalCompra {
  Future<String> inserCompraTotal(DetTotalCompra detalle) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");

    final search = await db
        .collection("detTotalCompra")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    if (search.isEmpty) {
      Map<String, dynamic> newDet;
      newDet = {
        "codigo": "DTC00001",
        "cod_encabezado": detalle.cod_encabezado,
        "cod_detunitcompra": detalle.cod_detunitcompra,
        "estado": detalle.estado,
      };

      await db.collection("detTotalCompra").add(newDet);

      return "DTC00001";
    } else {
      var codigo = search.map((e) => e.data()).toList().first["codigo"];
      String code = codigo.toString();
      code = "DTC${formatter.format(int.parse(code.substring(3)) + 1)}";

      Map<String, dynamic> newDet;
      newDet = {
        "codigo": code,
        "cod_encabezado": detalle.cod_encabezado,
        "cod_detunitcompra": detalle.cod_detunitcompra,
        "estado": detalle.estado,
      };

      await db.collection("detTotalCompra").add(newDet);
      return code;
    }
  }
}
