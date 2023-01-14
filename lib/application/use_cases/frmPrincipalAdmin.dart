import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/application/use_cases/frmManCategorias.dart';
import 'package:proy_final_renzo/application/use_cases/frmManComponentes.dart';
import 'package:proy_final_renzo/application/use_cases/frmManMarcas.dart';
import 'package:proy_final_renzo/application/use_cases/frmManUsuarios.dart';
import 'package:proy_final_renzo/application/use_cases/frmSettings.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Rectangular.dart';
import 'package:proy_final_renzo/application/widgets/Drawer_Personal.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class FrmPrincipalAdmin extends StatelessWidget {
  Personas persona;
  FrmPrincipalAdmin({
    Key? key,
    required this.persona,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/fondo.jpg"),
          invertColors: isDark,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: DrawerPersonal(persona: persona),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("R - STORE"),
              centerTitle: true,
              pinned: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FrmSettings(),
                      ),
                    );
                  },
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: 100,
                          child: Text(
                            "MENU",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      BotonRectangular(
                        w: 250,
                        texto: "Man Usuarios y Personas",
                        ejecutar: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FrmManUsuarios(persona: persona),
                              ));
                        },
                      ),
                      SizedBox(height: 20),
                      BotonRectangular(
                        w: 250,
                        texto: "Man Componentes",
                        ejecutar: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FrmManComponentes(persona: persona),
                              ));
                        },
                      ),
                      SizedBox(height: 20),
                      BotonRectangular(
                        w: 250,
                        texto: "Man Marcas",
                        ejecutar: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FrmManMarcas(persona: persona),
                              ));
                        },
                      ),
                      SizedBox(height: 20),
                      BotonRectangular(
                        w: 250,
                        texto: "Man Categorías",
                        ejecutar: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FrmManCategorias(persona: persona),
                              ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
