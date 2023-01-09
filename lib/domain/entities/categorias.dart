class Categorias {
  String _codigo, _nombre;
  Categorias(this._codigo, this._nombre);

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get nombre => _nombre;
  set nombre(String valor) {
    _nombre = valor;
  }
}
