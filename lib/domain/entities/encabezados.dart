class Encabezados {
  String _codigo, _cod_persona, _direccion, _cod_tipo_pago;
  DateTime _fecha_compra, _fecha_confirmacion, _fecha_recepcion;

  Encabezados(
      this._codigo,
      this._cod_persona,
      this._direccion,
      this._fecha_compra,
      this._fecha_confirmacion,
      this._fecha_recepcion,
      this._cod_tipo_pago);

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get cod_persona => _cod_persona;
  set cod_persona(String valor) {
    _cod_persona = valor;
  }

  String get direccion => _direccion;
  set direccion(String valor) {
    _direccion = valor;
  }

  DateTime get fecha_compra => _fecha_compra;
  set fecha_compra(DateTime valor) {
    _fecha_compra = valor;
  }

  DateTime get fecha_confirmacion => _fecha_confirmacion;
  set fecha_confirmacion(DateTime valor) {
    _fecha_confirmacion = valor;
  }

  DateTime get fecha_recepcion => _fecha_recepcion;
  set fecha_recepcion(DateTime valor) {
    _fecha_recepcion = valor;
  }

  String get cod_tipo_pago => _cod_tipo_pago;
  set cod_tipo_pago(String valor) {
    _cod_tipo_pago = valor;
  }
}
