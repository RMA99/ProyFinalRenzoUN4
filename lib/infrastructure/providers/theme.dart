import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  set isDark(bool valor) {
    _isDark = valor;
    notifyListeners();
  }
}
