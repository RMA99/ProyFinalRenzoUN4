import 'package:proy_final_renzo/infrastructure/controllers/cTipoPago.dart';

class eTipoPago {
  cTipoPago cd = cTipoPago();
  Future<List<String>> getListTPago() {
    return cd.getListTipoPago();
  }

  Future<String> getCodeE(String tipoPago) {
    return cd.getCode(tipoPago);
  }
}
