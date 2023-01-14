import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class TextFieldPersonal extends StatelessWidget {
  String texto;
  IconData tIcon;
  bool isVisible;
  String? Function(String?)? validacion;
  TextEditingController? controlador;
  double w;
  double h;
  TextFieldPersonal({
    Key? key,
    this.texto = "",
    this.tIcon = Icons.abc,
    this.isVisible = true,
    required this.validacion,
    required this.controlador,
    this.w = 300,
    this.h = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      height: h,
      width: w,
      child: TextFormField(
        //keyboardType: TextInputType.multiline,
        //expands: true,
        minLines: 5,
        maxLines: null,
        textAlignVertical: TextAlignVertical.center,
        controller: controlador,
        validator: validacion,
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
          prefixIcon: Icon(
            tIcon,
            color: isDark ? Colors.white : Colors.black,
          ),
          labelText: texto,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: isDark
              ? Color.fromARGB(130, 228, 225, 216)
              : Color.fromARGB(218, 207, 216, 217),
          // Color.fromARGB(81, 208, 175, 91
        ),
      ),
    );
  }
}
