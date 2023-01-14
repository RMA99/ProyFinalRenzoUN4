import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eMarcas.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

import '../widgets/Boton_Rectangular.dart';
import '../widgets/TextField_Personal.dart';

class FrmManMarcas extends StatelessWidget {
  Personas persona;
  FrmManMarcas({
    Key? key,
    required this.persona,
  }) : super(key: key);

  final txtSearch = TextEditingController();
  final txtCodigo = TextEditingController();
  final txtNombre = TextEditingController();

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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("R - STORE"),
              centerTitle: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: Text(
                            "Mantenimiento Marcas",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldPersonal(
                            w: 230,
                            validacion: null,
                            controlador: txtSearch,
                            texto: "Buscar por Código",
                            tIcon: Icons.search,
                          ),
                          SizedBox(width: 15),
                          BotonRectangular(
                            w: 100,
                            texto: "Buscar",
                            ejecutar: () async {
                              await search();
                              print("oh");
                            },
                          )
                        ],
                      ),
                      TextFieldPersonal(
                        w: 250,
                        validacion: null,
                        controlador: txtCodigo,
                        texto: "Codigo",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        w: 250,
                        validacion: null,
                        controlador: txtNombre,
                        texto: "Categoría",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BotonRectangular(
                            texto: "Registrar",
                            ejecutar: () async {
                              await registrar();
                            },
                            w: 120,
                          ),
                          BotonRectangular(
                            texto: "Actualizar",
                            ejecutar: () async {
                              await actualizar();
                            },
                            w: 120,
                          ),
                          BotonRectangular(
                            texto: "Eliminar",
                            ejecutar: () async {
                              await eliminar();
                            },
                            w: 120,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      )
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

  Future<void> search() async {
    eMarcas ema = eMarcas();
    txtNombre.text = await ema.getMarcasE(txtSearch.text);
    txtCodigo.text = txtSearch.text;
  }

  Future<void> actualizar() async {
    eMarcas ema = eMarcas();
    await ema.actualizarE(txtCodigo.text, txtNombre.text);
  }

  Future<void> registrar() async {
    eMarcas ema = eMarcas();
    await ema.registrarE(txtCodigo.text, txtNombre.text);
  }

  Future<void> eliminar() async {
    eMarcas ema = eMarcas();
    await ema.eliminarE(txtCodigo.text);
  }
}
