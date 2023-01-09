import 'package:proy_final_renzo/domain/entities/detTotalCompra.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cDetTotalCompra.dart';

class eDetTotalCompra {
  Future<String> inserCompraTotalE(
      String codeEncabezado, String codeDetUnitario) async {
    cDetTotalCompra cd = cDetTotalCompra();
    return await cd.inserCompraTotal(
        DetTotalCompra("", codeEncabezado, codeDetUnitario, "Pendiente"));
  }
}
