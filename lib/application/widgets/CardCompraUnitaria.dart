import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proy_final_renzo/domain/entities/componentes.dart';
import 'package:proy_final_renzo/domain/entities/detUnitCompra.dart';

class CardCompraUnitaria extends StatelessWidget {
  DetUnitCompra detalle;
  Componentes componente;
  CardCompraUnitaria({
    Key? key,
    required this.detalle,
    required this.componente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(componente.modelo),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(componente.detalle),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          // INSERT IMAGEN LINK
                          componente.imagen_path,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 100,
                          child: Text(
                            "Precio Unitario:",
                            textAlign: TextAlign.end,
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 80,
                        child: Text("S/.${detalle.precio_unit}"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 100,
                          child: Text(
                            "Cantidad:",
                            textAlign: TextAlign.end,
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 80,
                        child: Text(
                          "${detalle.cantidad} un.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 100,
                          child: Text(
                            "Precio Total:",
                            textAlign: TextAlign.end,
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 80,
                        child: Text("S/.${detalle.precio_total}"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
