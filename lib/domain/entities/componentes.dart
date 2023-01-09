class Componentes {
  String _codigo,
      _cod_categoria,
      _cod_marca,
      _modelo,
      _detalle,
      _estado,
      _imagen_path;

  int _stock;
  double _precio;

  Componentes(
      this._codigo,
      this._cod_categoria,
      this._cod_marca,
      this._modelo,
      this._detalle,
      this._estado,
      this._imagen_path,
      this._stock,
      this._precio);

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get cod_categoria => _cod_categoria;
  set cod_categoria(String valor) {
    _cod_categoria = valor;
  }

  String get cod_marca => _cod_marca;
  set cod_marca(String valor) {
    _cod_marca = valor;
  }

  String get modelo => _modelo;
  set modelo(String valor) {
    _modelo = valor;
  }

  String get detalle => _detalle;
  set detalle(String valor) {
    _detalle = valor;
  }

  String get estado => _estado;
  set estado(String valor) {
    _estado = valor;
  }

  String get imagen_path => _imagen_path;
  set imagen_path(String valor) {
    _imagen_path = valor;
  }

  int get stock => _stock;
  set stock(int valor) {
    _stock = valor;
  }

  double get precio => _precio;
  set precio(double valor) {
    _precio = valor;
  }
}
