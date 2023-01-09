import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/use_cases/Portada.dart';

class DrawerPersonal extends StatelessWidget {
  const DrawerPersonal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 127, 125, 125),
            ),
            child: Text("Usuario"),
          ),
          ListTile(
            title: Text("Cerrar Sesión"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Portada(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
