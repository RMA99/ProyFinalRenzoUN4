import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';

class cDetUnitCompra {
  Future<String> inserCompraUnitaria(DetUnitCompra detalle) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");

    final search = await db
        .collection("detUnitCompra")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    if (search.isEmpty) {
      Map<String, dynamic> newDet;
      newDet = {
        "codigo": "DUC00001",
        "cod_componente": detalle.cod_componente,
        "precio_unit": detalle.precio_unit,
        "cantidad": detalle.cantidad,
        "precio_total": detalle.precio_total,
      };

      await db.collection("detUnitCompra").add(newDet);

      return "DUC00001";
    } else {
      var codigo = search.map((e) => e.data()).toList().first["codigo"];
      String code = codigo.toString();
      code = "DUC${formatter.format(int.parse(code.substring(3)) + 1)}";

      Map<String, dynamic> newDet;
      newDet = {
        "codigo": code,
        "cod_componente": detalle.cod_componente,
        "precio_unit": detalle.precio_unit,
        "cantidad": detalle.cantidad,
        "precio_total": detalle.precio_total,
      };

      await db.collection("detUnitCompra").add(newDet);
      return code;
    }
  }
}
