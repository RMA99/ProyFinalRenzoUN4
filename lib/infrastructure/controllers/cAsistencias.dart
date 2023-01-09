import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proy_final_renzo/domain/entities/asistencias.dart';

class cAsistencias {
  void insertAsistencia(Asistencias dato) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String sesion = "";

    var minutos = int.parse(dato.fecha.substring(3));
    var horas = int.parse(dato.fecha.substring(0, 1));
    int time = 0;
    time = minutos + horas * 60;

    if (dato.fecha == "04/01/2023") {
      if (time <= 480) {
        sesion = "Sesion01";
      } else if (time <= 840) {
        sesion = "Sesion02";
      }
    } else if (dato.fecha == "05/01/2023") {
      if (time <= 480) {
      } else if (time <= 840) {
        sesion = "Sesion04";
      }
    }

    sesion = prueba(dato.fecha, time);

    sesion = "Sesion05";
    Map<String, dynamic> newAsist;
    newAsist = {
      "nombre": dato.nombre,
      "apellido": dato.apellidos,
      "fecha": dato.fecha,
      "hora": dato.hora,
      "sesion": sesion,
    };

    db.collection("asistencias").doc(dato.apellidos).set(newAsist);
  }

  String prueba(String fecha, int time) {
    String sesion = "";
    if (fecha == "04/01/2023") {
      if (time <= 480) {
        sesion = "Sesion01";
        return sesion;
      } else if (time <= 840) {
        sesion = "Sesion02";
        return sesion;
      }
    } else if (fecha == "05/01/2023") {
      if (time <= 480) {
        sesion = "Sesion03";
        return sesion;
      } else if (time <= 840) {
        sesion = "Sesion04";
        return sesion;
      }
    }
    return sesion;
  }
}
