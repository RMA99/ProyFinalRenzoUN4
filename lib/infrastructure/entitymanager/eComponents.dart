import 'package:proy_final_renzo/domain/entities/componentes.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cComponents.dart';

class eComponents {
  Future<List<String>> getListID_E() async {
    cComponentes cc = cComponentes();
    List<String> lista = await cc.getListID();
    return lista;
  }

  Future<Componentes> getComponentE(String id) async {
    cComponentes cc = cComponentes();

    Componentes componente = await cc.getComponent(id);
    return componente;
  }

  Future<Componentes> getComponentbyCodeE(String code) async {
    cComponentes cc = cComponentes();

    Componentes componente = await cc.getComponentbyCode(code);
    return componente;
  }

  Future<void> actualizarE(
      String codigo,
      String cod_categoria,
      String cod_marca,
      String modelo,
      String detalle,
      String estado,
      String imagen_path,
      int stock,
      double precio) async {
    cComponentes cc = cComponentes();

    await cc.actualizar(Componentes(codigo, cod_categoria, cod_marca, modelo,
        detalle, estado, imagen_path, stock, precio));
  }

  Future<void> registrarE(
      String codigo,
      String cod_categoria,
      String cod_marca,
      String modelo,
      String detalle,
      String estado,
      String imagen_path,
      int stock,
      double precio) async {
    cComponentes cc = cComponentes();

    await cc.registrar(Componentes(codigo, cod_categoria, cod_marca, modelo,
        detalle, estado, imagen_path, stock, precio));
  }

  Future<void> eliminarE(
    String codigo,
  ) async {
    cComponentes cc = cComponentes();

    await cc.eliminar(codigo);
  }
}
