class Marcas {
  String _codigo, _nombre;
  Marcas(this._codigo, this._nombre);

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get nombre => _nombre;
  set nombre(String valor) {
    _nombre = valor;
  }
}
