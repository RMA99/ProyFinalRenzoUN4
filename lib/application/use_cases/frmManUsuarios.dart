import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/application/use_cases/frmSettings.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Rectangular.dart';
import 'package:proy_final_renzo/application/widgets/Drawer_Personal.dart';
import 'package:proy_final_renzo/application/widgets/TextField_Personal.dart';
import 'package:proy_final_renzo/application/widgets/alertDialog.dart';
import 'package:proy_final_renzo/application/widgets/toast_Message.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cUsuarios.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eUsuarios.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class FrmManUsuarios extends StatelessWidget {
  Personas persona;
  FrmManUsuarios({
    Key? key,
    required this.persona,
  }) : super(key: key);

  final txtSearch = TextEditingController();
  final txtCodigo = TextEditingController();
  final txtCodeTipoUser = TextEditingController();
  final txtUsuario = TextEditingController();
  final txtClave = TextEditingController();

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
                            "Mantenimiento Usuarios",
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
                            texto: "Buscar por Usuario",
                            tIcon: Icons.search,
                          ),
                          SizedBox(width: 15),
                          BotonRectangular(
                            w: 100,
                            texto: "Buscar",
                            ejecutar: () {
                              Search();
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
                        controlador: txtCodeTipoUser,
                        texto: "Cod Tipo Usuario",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        w: 250,
                        validacion: null,
                        controlador: txtUsuario,
                        texto: "Usuario",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        w: 250,
                        validacion: null,
                        controlador: txtClave,
                        texto: "Clave",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BotonRectangular(
                            texto: "Registrar",
                            ejecutar: () {},
                            w: 120,
                          ),
                          BotonRectangular(
                            texto: "Actualizar",
                            ejecutar: () {},
                            w: 120,
                          ),
                          BotonRectangular(
                            texto: "Eliminar",
                            ejecutar: () {},
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

  Future<void> Search() async {
    if (txtSearch.text != null && txtSearch.text != "") {
      eUsuarios eu = eUsuarios();
      var usuario = await eu.getUsuarioE(txtSearch.text);

      txtCodigo.text = usuario.codigo;
      txtCodeTipoUser.text = usuario.cod_tipo_usuario;
      txtUsuario.text = usuario.logeo;
      txtClave.text = usuario.clave;
    } else {
      print("Error");
    }
  }
}
