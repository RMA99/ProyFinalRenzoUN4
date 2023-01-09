class DetUnitCompra {
  String _codigo, _cod_componente;
  int _cantidad;
  double _precio_unit, _precio_total;

  DetUnitCompra(
    this._codigo,
    this._cod_componente,
    this._cantidad,
    this._precio_unit,
    this._precio_total,
  );

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get cod_componente => _cod_componente;
  set cod_componente(String valor) {
    _cod_componente = valor;
  }

  int get cantidad => _cantidad;
  set cantidad(int valor) {
    _cantidad = valor;
  }

  double get precio_unit => _precio_unit;
  set precio_unit(double valor) {
    _precio_unit = valor;
  }

  double get precio_total => _precio_total;
  set precio_total(double valor) {
    _precio_total = valor;
  }
}
