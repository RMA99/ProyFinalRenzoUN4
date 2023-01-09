import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

toastMessage(String texto, bool isDark, BuildContext context) {
  return Fluttertoast.showToast(
    msg: texto,
    backgroundColor: isDark
        ? Color.fromARGB(255, 234, 226, 226)
        // Color.fromARGB(255, 184, 179, 179)
        : Color.fromARGB(255, 53, 52, 52),
    textColor: isDark ? Colors.black : Colors.white,
  );
}
