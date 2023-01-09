import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/departamentos.dart';

class cDepartamentos {
  Future<String> create(Departamentos dato) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    NumberFormat formatter = NumberFormat("00000");
    String estado = "nuevo";
    final search = await db
        .collection("usuarios")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    if (search.isEmpty) {
      Map<String, dynamic> newDep;
      newDep = {
        "codigo": "D00001",
        "departamento": dato.depa,
      };
      await db.collection("departamentos").doc(dato.depa).set(newDep);
      return estado;
    } else {
      var codigo = search.map((e) => e.data()).toList().first["codigo"];

      String code = codigo.toString();

      code = "D" + formatter.format(int.parse(code.substring(1)) + 1);

      Map<String, dynamic> newDep;
      newDep = {
        "codigo": code,
        "departamento": dato.depa,
      };
      var verificar = await db
          .collection("departamento")
          .doc(dato.depa)
          .get()
          .then((value) => value.data());

      if (verificar == null) {
        await db.collection("departamentos").doc(dato.depa).set(newDep);
        print("Añadido");
        return estado;
      } else {
        print("No añadido");
        estado = "duplicado";
        return estado;
      }
    }
  }

  Future<List<String>> getListDep() async {
    List<String> listDepartamentos = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db.collection("departamentos").get();
    lista.docs.map((e) => e.data()).toList().forEach((element) {
      listDepartamentos.add(element["departamento"]);
    });
    return listDepartamentos;
  }

  Future<String> getCode(String departamento) async {
    String codeDep;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("departamentos")
        .where("departamento", isEqualTo: departamento)
        .get();

    codeDep =
        lista.docs.map((e) => e.data()).toList().first["codigo"].toString();
    return codeDep;
  }
}
