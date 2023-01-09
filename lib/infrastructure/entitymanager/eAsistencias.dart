import 'package:proy_final_renzo/domain/entities/asistencias.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cAsistencias.dart';

class eAsistencias {
  cAsistencias ca = cAsistencias();

  void insertAsistenciaE(
      String nombre, String apellido, String fecha, String hora) {
    ca.insertAsistencia(Asistencias(nombre, apellido, fecha, hora, ""));
  }
}
