class Departamentos {
  String _codigo, _depa;

  Departamentos(this._codigo, this._depa);

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get depa => _depa;
  set depa(String valor) {
    _depa = valor;
  }
}
