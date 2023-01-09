class DetTotalCompra {
  String _codigo, _cod_encabezado, _cod_detunitcompra, _estado;

  DetTotalCompra(
    this._codigo,
    this._cod_encabezado,
    this._cod_detunitcompra,
    this._estado,
  );

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get cod_encabezado => _cod_encabezado;
  set cod_encabezado(String valor) {
    _cod_encabezado = valor;
  }

  String get cod_detunitcompra => _cod_detunitcompra;
  set cod_detunitcompra(String valor) {
    _cod_detunitcompra = valor;
  }

  String get estado => _estado;
  set estado(String valor) {
    _estado = valor;
  }
}
