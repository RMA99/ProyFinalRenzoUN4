class Asistencias {
  String _nombre, _apellidos, _fecha, _hora, _sesion;

  Asistencias(
      this._nombre, this._apellidos, this._fecha, this._hora, this._sesion);

  String get nombre => _nombre;
  set nombre(String valor) {
    _nombre = valor;
  }

  String get apellidos => _apellidos;
  set apellidos(String valor) {
    _apellidos = valor;
  }

  String get fecha => _fecha;
  set fecha(String valor) {
    _fecha = valor;
  }

  String get hora => _hora;
  set hora(String valor) {
    _hora = valor;
  }

  String get sesion => _sesion;
  set sesion(String valor) {
    _sesion = valor;
  }
}
