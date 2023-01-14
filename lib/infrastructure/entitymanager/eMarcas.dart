import 'package:proy_final_renzo/domain/entities/marcas.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cMarcas.dart';

class eMarcas {
  cMarcas ec = cMarcas();
  Future<String> getCodeE(String marcas) {
    return ec.getCode(marcas);
  }

  Future<String> getMarcasE(String codigo) {
    return ec.getMarcas(codigo);
  }

  Future<List<String>> getListMarcasE() {
    return ec.getListMarcas();
  }

  Future<void> actualizarE(String codigo, String nombre) async {
    await ec.actualizar(Marcas(codigo, nombre));
  }

  Future<void> registrarE(String codigo, String nombre) async {
    await ec.registrar(Marcas(codigo, nombre));
  }

  Future<void> eliminarE(String codigo) async {
    await ec.eliminar(codigo);
  }
}
