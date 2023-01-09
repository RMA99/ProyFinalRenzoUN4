import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/use_cases/frmPrincipal.dart';
import 'package:proy_final_renzo/application/use_cases/frmRegistro.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Rectangular.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Transparente.dart';
import 'package:proy_final_renzo/application/widgets/TextField_Personal.dart';
import 'package:proy_final_renzo/application/widgets/toast_Message.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/ePersonas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eUsuarios.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

class FrmLogin extends StatelessWidget {
  FrmLogin({super.key});

  final txtuser = TextEditingController();
  final txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    eUsuarios eu = eUsuarios();

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
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        const Text(
                          "INICIO DE SESIÓN",
                          style: TextStyle(
                            fontFamily: "NotoNastaliqUrdu",
                            fontSize: 30,
                            //fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFieldPersonal(
                          validacion: null,
                          controlador: txtuser,
                          texto: "Usuario",
                          tIcon: Icons.person,
                        ),
                        TextFieldPersonal(
                          validacion: null,
                          controlador: txtpassword,
                          texto: "Clave",
                          tIcon: Icons.password,
                        ),
                        BotonRectangular(
                          texto: "Ingresar",
                          ejecutar: () async {
                            var isuser = await eu.isUserE(
                                txtuser.text, txtpassword.text);
                            //////////////////////
                            /////////////////////////
                            // isuser = true; // CORREGIR CAMBIO
                            ////////////////////////////////////
                            //////////////////////////////
                            if (isuser) {
                              var persona = await getPersona();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FrmPrincipal(persona: persona),
                                ),
                              );
                            } else {
                              toastMessage("Usuario y/o contraseña incorrecto",
                                  isDark, context);
                            }
                          },
                        ),
                        BotonTransparente(
                          texto: "Registrarse",
                          ejecutar: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FrmRegistro(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Personas> getPersona() async {
    ePersonas ep = ePersonas();
    eUsuarios eu = eUsuarios();
    String codeUSer = await eu.getcodeE(txtuser.text);
    Personas persona = await ep.getPersonaE(codeUSer);
    return persona;
  }
}
