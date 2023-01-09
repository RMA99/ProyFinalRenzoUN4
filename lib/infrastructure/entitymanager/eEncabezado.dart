import 'package:proy_final_renzo/infrastructure/controllers/cEncabezados.dart';

class eEncabezado {
  Future<String> createEncabezadoE(
      String cod_persona, String direccion, String tipoPago) async {
    cEncabezados ce = cEncabezados();

    return await ce.createEncabezado(cod_persona, direccion, tipoPago);
  }
}
