import 'package:proy_final_renzo/infrastructure/controllers/cMarcas.dart';

class eMarcas {
  cMarcas ec = cMarcas();
  Future<String> getCodeE(String marcas) {
    return ec.getCode(marcas);
  }

  Future<String> getMarcasE(String codigo) {
    return ec.getMarcas(codigo);
  }
}
