import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';
import 'package:proy_final_renzo/infrastructure/providers/prevListCarrito.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class CardComponent extends StatefulWidget {
  String titulo;
  String detalle;
  String pathImage;
  String marca;
  String categoria;
  double precio;
  int stock;
  String codigo;

  CardComponent({
    Key? key,
    this.titulo = "",
    this.detalle = "",
    this.pathImage = "",
    this.marca = "",
    this.categoria = "",
    this.precio = 0,
    this.stock = 0,
    this.codigo = "",
  }) : super(key: key);

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  //final listado = context.select<ThemeProvider, bool>//((bloc) => bloc.isDark);
  int contador = 0;
  bool isactivated = true;
  @override
  Widget build(BuildContext context) {
    final carritoListas = Provider.of<PrevListCarritoProvider>(context);
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    List<DetUnitCompra> listado = carritoListas.listPreliminar;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      shadowColor: Color.fromARGB(255, 82, 116, 131),
      elevation: 15,
      color: isDark
          ? Color.fromARGB(199, 119, 118, 118)
          : Color.fromARGB(200, 255, 255, 255),
      child: Container(
        alignment: Alignment.center,
        width: 370,
        height: 200,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    height: 35,
                    alignment: Alignment.center,
                    child: Text(
                      //INSERT TITULO
                      widget.titulo,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  // INSERT IMAGEN LINK
                                  widget.pathImage,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      //INSERT DETALLE
                                      widget.detalle,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text("Marca:"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(widget.marca)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Categoría:"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(widget.categoria)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Stock:"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${widget.stock} un.")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Precio:"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("S/.${widget.precio}")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black,
                          radius: 50,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          onTap: () {
                            setState(() {
                              if (isactivated) {
                                contador = contador + 1;
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              "assets/images/mas.png",
                              fit: BoxFit.cover,
                              color: isactivated ? null : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "$contador",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black,
                          radius: 50,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          onTap: () {
                            setState(() {
                              if (contador == 0) {
                                contador = 0;
                              } else {
                                if (isactivated) {
                                  contador = contador - 1;
                                }
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              "assets/images/menos.png",
                              fit: BoxFit.cover,
                              color: isactivated ? null : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black,
                    radius: 50,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    onTap: () {
                      setState(() {
                        //print(contador);
                        //print(widget.pathImage);
                        var detalle = agregarDetalle();
                        if (isactivated == true) {
                          listado.add(detalle);
                          carritoListas.items = listado.length;
                          isactivated = !isactivated;
                          if (listado.length == 0) {
                            carritoListas.isEmpty = true;
                          } else {
                            carritoListas.isEmpty = false;
                          }
                        } else {
                          listado.removeWhere((element) =>
                              element.cod_componente == widget.codigo);
                          carritoListas.items = listado.length;
                          isactivated = !isactivated;
                          if (listado.length == 0) {
                            carritoListas.isEmpty = true;
                          } else {
                            carritoListas.isEmpty = false;
                          }
                        }
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                          isactivated
                              ? Icons.local_grocery_store_outlined
                              : Icons.remove_shopping_cart_outlined,
                          size: 35),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DetUnitCompra agregarDetalle() {
    double precioTotal = contador * widget.precio;
    String precioRedondo = precioTotal.toStringAsFixed(2);
    precioTotal = double.parse(precioRedondo);
    DetUnitCompra detalle =
        DetUnitCompra("", widget.codigo, contador, widget.precio, precioTotal);
    return detalle;
  }
}
