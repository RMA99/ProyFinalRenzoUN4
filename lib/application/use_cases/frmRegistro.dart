import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/use_cases/frmlogin.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Rectangular.dart';
import 'package:proy_final_renzo/application/widgets/Drawer_Personal.dart';
import 'package:proy_final_renzo/application/widgets/DropDownPersonal.dart';
import 'package:proy_final_renzo/application/widgets/TextField_Personal.dart';
import 'package:proy_final_renzo/application/widgets/alertDialog.dart';
import 'package:proy_final_renzo/application/widgets/toast_Message.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eDepartamentos.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/ePersonas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eUsuarios.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

class FrmRegistro extends StatefulWidget {
  FrmRegistro({super.key});

  @override
  State<FrmRegistro> createState() => _FrmRegistroState();
}

class _FrmRegistroState extends State<FrmRegistro> {
  var listDepartamentos = ["Error"];
  String vista = "";
  final txtNombres = TextEditingController();
  final txtApellidos = TextEditingController();
  final txtDni = TextEditingController();
  final txtUsuario = TextEditingController();
  final txtContrasena = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(vista);
    consultaDepartamentos();
    //this.vista = "Seleccione su departamento";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    final formkey = GlobalKey<FormState>();

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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "REGISTRO DE USUARIO",
                          style: TextStyle(
                            fontFamily: "NotoNastaliqUrdu",
                            fontSize: 30,
                            //fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFieldPersonal(
                          validacion: null,
                          controlador: txtNombres,
                          texto: "Nombres",
                          tIcon: Icons.person,
                        ),
                        TextFieldPersonal(
                          validacion: null,
                          controlador: txtApellidos,
                          texto: "Apellidos",
                          tIcon: Icons.person_outline_rounded,
                        ),
                        TextFieldPersonal(
                          validacion: (valor) {
                            return (isValidDni(valor.toString()))
                                ? null
                                : "Ingrese un DNI Válido";
                          },
                          controlador: txtDni,
                          texto: "DNI",
                          tIcon: Icons.numbers,
                        ),
                        DropDownPersonal(
                          viewDefault: vista,
                          listado: listDepartamentos,
                          onChange: (valor) {
                            setState(() {
                              vista = valor.toString();
                            });
                          },
                        ),
                        TextFieldPersonal(
                          validacion: null,
                          controlador: txtUsuario,
                          texto: "Usuario",
                          tIcon: Icons.person_add_alt,
                        ),
                        TextFieldPersonal(
                          validacion: null,
                          controlador: txtContrasena,
                          texto: "Contraseña",
                          tIcon: Icons.password,
                          //isVisible: false,
                        ),
                        SizedBox(height: 10),
                        BotonRectangular(
                          texto: "Registrarse",
                          ejecutar: () async {
                            final isValidForm =
                                formkey.currentState!.validate();
                            if (isValidForm) {
                              if (await registroUsuarioPersona()) {
                                toastMessage("Usuario creado correctamente",
                                    isDark, context);
                              }
                            } else {
                              toastMessage(
                                  "Algunos de los datos ingresados son incorrectos",
                                  isDark,
                                  context);
                            }
                          },
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            eDepartamentos ed = eDepartamentos();
            String codeDep = await ed.getCodeE(vista);
            print(codeDep);
          },
          child: Icon(Icons.abc),
        ),
      ),
    );
  }

  void consultaDepartamentos() async {
    eDepartamentos ed = eDepartamentos();
    var valor = await ed.getListDepE();
    setState(() {
      this.listDepartamentos = valor;
      this.vista = "Departamento";
    });
  }

  Future<bool> registroUsuarioPersona() async {
    ePersonas ep = ePersonas();
    eUsuarios eu = eUsuarios();
    eDepartamentos ed = eDepartamentos();
    var isDuplicado = await ep.isDuplicatedE(txtDni.text);

    if (!isDuplicado) {
      String estado =
          await eu.insert_userE("TU00002", txtUsuario.text, txtContrasena.text);

      if (estado != "duplicado") {
        String codeDep = await ed.getCodeE(vista);
        String codeUser = await eu.getcodeE(txtUsuario.text);
        String validado = await ep.inserPersonaE(
            codeUser, codeDep, txtNombres.text, txtApellidos.text, txtDni.text);
        if (validado != "duplicado") {
          print("Casi Logrado");
          return true;
        } else {
          print("Casi Malogrado");
          return false;
        }

/*
        Future<bool> x() async {
          String validado = await ep.inserPersonaE(
              codeUser, vista, txtNombres.text, txtApellidos.text, txtDni.text);

          if (validado != "duplicado") {
            print("Casi Logrado");
            return true;
          } else {
            print("Casi Malogrado");
            return false;
          }
        }
        return x();*/

      } else {
        alertDialog_ok(
            context, "El nombre de usuario no está disponible", "Alerta");
        return false;
      }
    } else {
      alertDialog_ok(context, "Usuario ya registrado", "Alerta");
      return false;
    }
  }

  bool isValidDni(String dni) {
    if (dni == null || dni == ("")) {
      return false;
    }
    if (dni.length != 8) {
      return false;
    }
    if (!dni.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    return true;
  }
}
