import 'package:proy_final_renzo/infrastructure/controllers/cDepartamentos.dart';

class eDepartamentos {
  cDepartamentos cd = cDepartamentos();
  Future<List<String>> getListDepE() {
    return cd.getListDep();
  }

  Future<String> getCodeE(String departamento) {
    return cd.getCode(departamento);
  }
}
