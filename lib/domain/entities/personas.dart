class Personas {
  String _codigo, _cod_usuario, _cod_departamento, _nombre, _apellido, _dni;
  Personas(this._codigo, this._cod_usuario, this._cod_departamento,
      this._nombre, this._apellido, this._dni);

  String get codigo => _codigo;
  set codigo(String valor) {
    _codigo = valor;
  }

  String get cod_usuario => _cod_usuario;
  set cod_usuario(String valor) {
    _cod_usuario = valor;
  }

  String get cod_departamento => _cod_departamento;
  set cod_departamento(String valor) {
    _cod_departamento = valor;
  }

  String get nombre => _nombre;
  set nombre(String valor) {
    _nombre = valor;
  }

  String get apellido => _apellido;
  set apellido(String valor) {
    _apellido = valor;
  }

  String get dni => _dni;
  set dni(String valor) {
    _dni = valor;
  }
}
