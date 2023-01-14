import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class DropDownPersonal extends StatefulWidget {
  String viewDefault;
  List<String> listado;
  void Function(String?)? onChange;
  double w;

  DropDownPersonal({
    Key? key,
    required this.viewDefault,
    required this.listado,
    required this.onChange,
    this.w = 300,
  }) : super(key: key);

  @override
  State<DropDownPersonal> createState() => _DropDownPersonalState();
}

class _DropDownPersonalState extends State<DropDownPersonal> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    return Container(
      width: widget.w,
      height: 60,
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark
            ? Color.fromARGB(130, 228, 225, 216)
            : Color.fromARGB(218, 207, 216, 217),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton(
        underline: Container(),
        isExpanded: true,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 17,
        ),
        items: widget.listado
            .map(
              (String e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),
        onChanged: widget.onChange,
        hint: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(Icons.format_list_bulleted_rounded),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              widget.viewDefault,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
