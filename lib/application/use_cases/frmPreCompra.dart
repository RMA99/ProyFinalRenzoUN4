import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/use_cases/frmRegistroCompra.dart';
import 'package:proy_final_renzo/application/widgets/CardCompraUnitaria.dart';
import 'package:proy_final_renzo/domain/entities/componentes.dart';
import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eComponents.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eDetUnitCompra.dart';
import 'package:proy_final_renzo/infrastructure/providers/prevListCarrito.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

class FrmPreCompra extends StatelessWidget {
  Personas persona;
  FrmPreCompra({
    Key? key,
    required this.persona,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    final listado =
        context.select<PrevListCarritoProvider, List<DetUnitCompra>>(
            (bloc) => bloc.listPreliminar);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/fondo.jpg"),
          invertColors: isDark,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("CARRITO - COMPRA"),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      listaItemsCompra(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (() async {
            List<String> result = [];
            String valor = "";
            for (int i = 0; i < listado.length; i++) {
              eDetUnitCompra ed = eDetUnitCompra();
              valor = await ed.inserCompraUnitariaE(listado[i]);
              result.add(valor);
            }
            print(result[0]);
            print(result.length);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FrmRegistroCompra(
                    persona: persona,
                    listCodigoCompraUnitaria: result,
                  ),
                ));

            print(listado.length);
          }),
          label: Row(
            children: [
              Text("Continuar"),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget listaItemsCompra(BuildContext context) {
    final listado =
        context.select<PrevListCarritoProvider, List<DetUnitCompra>>(
            (bloc) => bloc.listPreliminar);

    Future<List<Widget>> getColumnas() async {
      List<Widget> columna = [];
      for (int i = 0; i < listado.length; i++) {
        eComponents ec = eComponents();
        DetUnitCompra detalle = listado[i];
        Componentes componente =
            await ec.getComponentbyCodeE(detalle.cod_componente);

        columna
            .add(CardCompraUnitaria(detalle: detalle, componente: componente));
      }
      return columna;
    }

    return FutureBuilder(
      future: getColumnas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
