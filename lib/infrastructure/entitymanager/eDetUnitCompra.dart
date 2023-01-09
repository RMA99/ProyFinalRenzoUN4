import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cDetUnitCompra.dart';

class eDetUnitCompra {
  Future<String> inserCompraUnitariaE(DetUnitCompra detalle) async {
    cDetUnitCompra cd = cDetUnitCompra();
    return await cd.inserCompraUnitaria(detalle);
  }
}
