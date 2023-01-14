import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/use_cases/Portada.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';

class DrawerPersonal extends StatelessWidget {
  Personas persona;
  DrawerPersonal({
    required this.persona,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 171, 222, 204),
            ),
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/avatar.png",
                      width: 110,
                    ),
                    Text(
                      persona.nombre + " " + persona.apellido,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.store),
            tileColor: Color.fromARGB(255, 229, 234, 232),
            title: Text(
              "Productos",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Portada(),
                ),
              );
            },
          ),
          Container(
            height: 1,
            child: Column(),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            tileColor: Color.fromARGB(255, 229, 234, 232),
            title: Text(
              "Cerrar Sesión",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
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
