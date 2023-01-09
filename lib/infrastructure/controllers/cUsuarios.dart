import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:proy_final_renzo/application/widgets/toast_Message.dart';
import 'package:proy_final_renzo/domain/entities/usuarios.dart';

class cUsuarios {
  Future<String> insert_user(usuarios dato) async {
    NumberFormat formatter = NumberFormat("00000");
    FirebaseFirestore db = FirebaseFirestore.instance;
    String estado;

    final search = await db
        .collection("usuarios")
        .orderBy("codigo", descending: true)
        .get();

    if (search.docs.isEmpty) {
      Map<String, dynamic> newUSer;
      newUSer = {
        "codigo": "U00001",
        "cod_tipo_usuario": dato.cod_tipo_usuario,
        "logeo": dato.logeo,
        "clave": dato.clave
      };
      await db.collection("usuarios").doc(dato.logeo).set(newUSer);
      estado = "nuevo";
      return estado;
    } else {
      var codigo = search.docs.map((e) => e.data()).toList().first["codigo"];

      String code = codigo.toString();

      code = "U" + formatter.format(int.parse(code.substring(1)) + 1);

      Map<String, dynamic> newUSer;
      newUSer = {
        "codigo": code,
        "cod_tipo_usuario": dato.cod_tipo_usuario,
        "logeo": dato.logeo,
        "clave": dato.clave
      };
      var verificar = await db
          .collection("usuarios")
          .doc(dato.logeo)
          .get()
          .then((value) => value.data());

      if (verificar == null) {
        estado = "nuevo";
        await db.collection("usuarios").doc(dato.logeo).set(newUSer);
        print("Añadido");
        return estado;
      } else {
        print("No añadido");
        estado = "duplicado";
        return estado;
      }
    }
  }

  Future<bool> isUser(usuarios dato) async {
    //List searchResult = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    final result = await db
        .collection("usuarios")
        .where("logeo", isEqualTo: dato.logeo)
        .get();
    if (result.docs.isEmpty) {
      return false;
    } else {
      var dbclave =
          result.docs.map((e) => e.data()).toList().first["clave"].toString();

      if (dbclave == dato.clave) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<String> getcode(String usuario) async {
    String codeUser;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var lista = await db
        .collection("usuarios")
        .where("logeo", isEqualTo: usuario)
        .get();

    codeUser =
        lista.docs.map((e) => e.data()).toList().first["codigo"].toString();
    return codeUser;
  }
}

void search() async {
  List searchResult = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  final result =
      await db.collection("personas").where("codigo", isEqualTo: "P0002").get();
  //final valor = result.docs.map((e) => e.data());
  //final xd = valor['nombre'];
  final asd = result.docs.map((e) => e.data());

  searchResult = result.docs.map((e) => e.data()).toList();
  //final prueba = searchResult.asMap().;
  //prueba["0"];
  print(asd);
  //print(searchReult[0]["nombre"]);
}
