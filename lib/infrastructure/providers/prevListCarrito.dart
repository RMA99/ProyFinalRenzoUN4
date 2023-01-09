import 'package:flutter/cupertino.dart';
import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';

class PrevListCarritoProvider with ChangeNotifier {
  List<DetUnitCompra> _listPreliminar = [];
  bool _isEmpty = true;
  int _items = 0;

  List<DetUnitCompra> get listPreliminar => _listPreliminar;
  set listPreliminar(List<DetUnitCompra> valor) {
    _listPreliminar = valor;
    notifyListeners();
  }

  bool get isEmpty => _isEmpty;
  set isEmpty(bool valor) {
    _isEmpty = valor;
    notifyListeners();
  }

  int get items => _items;
  set items(int valor) {
    _items = valor;
    notifyListeners();
  }
}
