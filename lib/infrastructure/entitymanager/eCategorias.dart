import 'package:proy_final_renzo/domain/entities/categorias.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cCategorias.dart';

class eCategorias {
  cCategorias ec = cCategorias();
  Future<String> getCodeE(String categorias) {
    return ec.getCode(categorias);
  }

  Future<String> getCategoriaE(String codigo) {
    return ec.getCategoria(codigo);
  }

  Future<List<String>> getListCategoriasE() {
    return ec.getListCategorias();
  }

  Future<void> actualizarE(String codigo, String nombre) async {
    await ec.actualizar(Categorias(codigo, nombre));
  }

  Future<void> registrarE(String codigo, String nombre) async {
    await ec.registrar(Categorias(codigo, nombre));
  }

  Future<void> eliminarE(String codigo) async {
    await ec.eliminar(codigo);
  }
}
