import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/widgets/DropDownPersonal.dart';
import 'package:proy_final_renzo/application/widgets/TextField_Personal.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cEncabezados.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eDetTotalCompra.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eEncabezado.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eTipoUsuario.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

class FrmRegistroCompra extends StatefulWidget {
  Personas persona;
  List<String> listCodigoCompraUnitaria;
  FrmRegistroCompra({
    Key? key,
    this.listCodigoCompraUnitaria = const [],
    required this.persona,
  }) : super(key: key);
  String vista = "Tipo de Pago";
  final txtDireccion = TextEditingController();

  @override
  State<FrmRegistroCompra> createState() => _FrmRegistroCompraState();
}

class _FrmRegistroCompraState extends State<FrmRegistroCompra> {
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
              title: Text("REGISTRO DATOS PARA COMPRA"),
              centerTitle: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      TextFieldPersonal(
                        validacion: null,
                        controlador: widget.txtDireccion,
                        texto: "Dirección",
                        tIcon: Icons.add_location,
                      ),
                      DropDownPersonal(
                        viewDefault: widget.vista,
                        listado: ["Efectivo", "Tarjeta Credito"],
                        onChange: (valor) {
                          setState(() {
                            widget.vista = valor.toString();
                          });
                        },
                      ),
                      Text("Logrados !!"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var codeEncabezado = await insertarEnca_getCode(widget.vista);
            print(codeEncabezado);
            var lis = insertComprasTotales(
                codeEncabezado, widget.listCodigoCompraUnitaria);

            print(lis);
            print(widget.vista);
          },
          child: Icon(Icons.adb_outlined),
        ),
      ),
    );
  }

  Future<String> insertarEnca_getCode(String vistas) async {
    eEncabezado ee = eEncabezado();
    eTipoPago et = eTipoPago();
    var codeTipoPago = await et.getCodeE(vistas);
    var codeEncabezado = await ee.createEncabezadoE(
        widget.persona.codigo, widget.txtDireccion.text, codeTipoPago);
    return codeEncabezado;
  }

  Future<List> insertComprasTotales(
      String codeEncabezado, List listaCodeUnitarios) async {
    List listadoTotalesCode = [];
    for (int i = 0; i < listaCodeUnitarios.length; i++) {
      eDetTotalCompra ed = eDetTotalCompra();
      var codeDetUnitario = listaCodeUnitarios[i];
      var result = await ed.inserCompraTotalE(codeEncabezado, codeDetUnitario);
      listadoTotalesCode.add(result);
    }
    return listadoTotalesCode;
  }
}
