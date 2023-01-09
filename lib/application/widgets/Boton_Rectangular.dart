import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class BotonRectangular extends StatelessWidget {
  double w;
  double h;
  String texto = "";
  void Function() ejecutar = () {};
  BotonRectangular({
    Key? key,
    this.w = 170,
    this.h = 50,
    required this.texto,
    required this.ejecutar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    return Container(
      width: w,
      height: h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? Color.fromARGB(255, 221, 231, 230)
              : Color.fromARGB(255, 68, 68, 66),
        ),
        onPressed: ejecutar,
        child: Text(
          texto,
          style: TextStyle(
              fontSize: 19, color: isDark ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
