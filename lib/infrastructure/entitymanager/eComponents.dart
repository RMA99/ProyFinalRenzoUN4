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
}
