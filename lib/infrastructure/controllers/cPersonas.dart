import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';

class cPersonas {
  Future<String> inserPersona(Personas dato) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    NumberFormat formatter = NumberFormat("00000");
    String estado = "nuevo";

    final search = await db
        .collection("personas")
        .orderBy("codigo", descending: true)
        .get()
        .then((value) => value.docs);
    if (search.isEmpty) {
      Map<String, dynamic> newPer;
      newPer = {
        "codigo": "P00001",
        "cod_usuario": dato.cod_usuario,
        "cod_departamento": dato.cod_departamento,
        "nombre": dato.nombre,
        "apellido": dato.apellido,
        "dni": dato.dni
      };
      await db.collection("personas").doc(dato.dni).set(newPer);
      return estado;
    } else {
      var codigo = search.map((e) => e.data()).toList().first["codigo"];
      String code = codigo.toString();
      code = "P${formatter.format(int.parse(code.substring(1)) + 1)}";

      Map<String, dynamic> newPer;
      newPer = {
        "codigo": code,
        "cod_usuario": dato.cod_usuario,
        "cod_departamento": dato.cod_departamento,
        "nombre": dato.nombre,
        "apellido": dato.apellido,
        "dni": dato.dni
      };
      var verificar = await db
          .collection("personas")
          .doc(dato.dni)
          .get()
          .then((value) => value.data());

      if (verificar == null) {
        await db.collection("personas").doc(dato.dni).set(newPer);
        print("Añadido");
        return estado;
      } else {
        print("No añadido");
        estado = "duplicado";
        return estado;
      }
    }
  }

  Future<bool> isDuplicated(String dni) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var document = await db.collection("personas").doc(dni).get();
    if (document.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<Personas> getPersona(String codUser) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("personas")
        .where("cod_usuario", isEqualTo: codUser)
        .get();

    var personDB = lista.docs.map((e) => e.data()).toList().first;
    String codigo = personDB["codigo"];
    String cod_usuario = personDB["cod_usuario"];
    String cod_departamento = personDB["cod_departamento"];
    String nombre = personDB["nombre"];
    String apellido = personDB["apellido"];
    String dni = personDB["dni"];

    Personas persona =
        Personas(codigo, cod_usuario, cod_departamento, nombre, apellido, dni);
    return persona;
  }
}
