import 'package:proy_final_renzo/infrastructure/controllers/cCategorias.dart';

class eCategorias {
  cCategorias ec = cCategorias();
  Future<String> getCodeE(String categorias) {
    return ec.getCode(categorias);
  }

  Future<String> getCategoriaE(String codigo) {
    return ec.getCategoria(codigo);
  }
}
