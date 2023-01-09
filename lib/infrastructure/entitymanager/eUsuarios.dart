import 'package:proy_final_renzo/domain/entities/usuarios.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cUsuarios.dart';

class eUsuarios {
  cUsuarios cu = cUsuarios();

  Future<String> insert_userE(
      String cod_tipo_usuario, String logeo, String clave) {
    return cu.insert_user(usuarios("", cod_tipo_usuario, logeo, clave));
  }

  Future<bool> isUserE(String logeo, String clave) {
    return cu.isUser(usuarios("", "", logeo, clave));
  }

  Future<String> getcodeE(String usuario) {
    return cu.getcode(usuario);
  }
}
