import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proy_final_renzo/application/use_cases/frmPreCompra.dart';
import 'package:proy_final_renzo/application/use_cases/frmSettings.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Rectangular.dart';
import 'package:proy_final_renzo/application/widgets/CardComponent.dart';
import 'package:proy_final_renzo/application/widgets/Drawer_Personal.dart';
import 'package:proy_final_renzo/application/widgets/TextField_Personal.dart';
import 'package:proy_final_renzo/application/widgets/alertDialog.dart';
import 'package:proy_final_renzo/application/widgets/toast_Message.dart';
import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cComponents.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eAsistencias.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eCategorias.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eComponents.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eMarcas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eUsuarios.dart';
import 'package:proy_final_renzo/infrastructure/providers/prevListCarrito.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

class FrmPrincipal extends StatelessWidget {
  Personas persona;
  FrmPrincipal({
    Key? key,
    required this.persona,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    final carritoListas = Provider.of<PrevListCarritoProvider>(context);
    List<DetUnitCompra> listado = carritoListas.listPreliminar;

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
                      FutureBuilder(
                        future: ListaCompletaComponentes(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Text(persona.apellido),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(
          clipBehavior: Clip.none,
          backgroundColor: Colors.transparent,
          disabledElevation: 0,
          focusElevation: 0,
          onPressed: null,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !carritoListas.isEmpty,
                child: Container(
                  alignment: Alignment.center,
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 54, 7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "${carritoListas.items}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FrmPreCompra(persona: persona),
                        ));
                  },
                  splashColor: Colors.amber[100],
                  borderRadius: BorderRadius.circular(20.0),
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 176, 5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> ListaCompletaComponentes() async {
    eComponents eco = eComponents();
    eCategorias eca = eCategorias();
    eMarcas em = eMarcas();
    List<Widget> listCard = [];

    List<String> lista = await eco.getListID_E();
    for (int i = 0; i < lista.length; i++) {
      var idComponent = lista[i];
      var component = await eco.getComponentE(idComponent);
      String categoria = await eca.getCategoriaE(component.cod_categoria);
      String marca = await em.getMarcasE(component.cod_marca);
      CardComponent item = CardComponent(
        categoria: categoria,
        marca: marca,
        detalle: component.detalle,
        pathImage: component.imagen_path,
        precio: component.precio,
        titulo: component.modelo,
        stock: component.stock,
        codigo: component.codigo,
      );
      listCard.add(item);
    }
    Column columna = Column(children: listCard);

    return columna;
  }
}
