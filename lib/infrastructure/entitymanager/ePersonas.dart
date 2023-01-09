import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cPersonas.dart';

class ePersonas {
  cPersonas cp = cPersonas();

  Future<String> inserPersonaE(String cod_usuario, String cod_departamento,
      String nombre, String apellido, String dni) {
    return cp.inserPersona(
        Personas("", cod_usuario, cod_departamento, nombre, apellido, dni));
  }

  Future<bool> isDuplicatedE(String dni) {
    return cp.isDuplicated(dni);
  }

  Future<Personas> getPersonaE(String codeUser) {
    return cp.getPersona(codeUser);
  }
}
