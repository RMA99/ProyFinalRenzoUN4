import 'package:flutter/material.dart';

class UnitSettings extends StatelessWidget {
  String texto;
  double h;
  var interaction;
  UnitSettings({
    Key? key,
    this.texto = "",
    this.h = 50,
    this.interaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              width: 300,
              height: h,
              child: Text(
                texto,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              width: 50,
              height: h,
              child: interaction,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 1,
          decoration: BoxDecoration(color: Color.fromARGB(255, 211, 208, 208)),
        ),
      ],
    );
  }
}
