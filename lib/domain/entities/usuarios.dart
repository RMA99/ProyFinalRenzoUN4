class usuarios {
  String _codigo, _cod_tipo_usuario, _logeo, _clave;
  usuarios(this._codigo, this._cod_tipo_usuario, this._logeo, this._clave);
  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get cod_tipo_usuario => _cod_tipo_usuario;
  set cod_tipo_usuario(String valor) {
    _cod_tipo_usuario = valor;
  }

  String get logeo => _logeo;
  set logeo(String valor) {
    _logeo = valor;
  }

  String get clave => _clave;
  set clave(String valor) {
    _clave = valor;
  }
}
