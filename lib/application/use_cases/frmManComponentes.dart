import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/application/widgets/Boton_Rectangular.dart';
import 'package:proy_final_renzo/application/widgets/DropDownPersonal.dart';
import 'package:proy_final_renzo/application/widgets/TextField_Personal.dart';
import 'package:proy_final_renzo/domain/entities/categorias.dart';
import 'package:proy_final_renzo/domain/entities/personas.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eCategorias.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eComponents.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eMarcas.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class FrmManComponentes extends StatefulWidget {
  Personas persona;
  FrmManComponentes({
    Key? key,
    required this.persona,
  }) : super(key: key);

  @override
  State<FrmManComponentes> createState() => _FrmManComponentesState();
}

class _FrmManComponentesState extends State<FrmManComponentes> {
  var imagen;
  String marca = "";
  String categoria = "";
  var listCategorias = ["Error"];
  var listMarcas = ["Error"];
  final txtSearch = TextEditingController();
  final txtCodigo = TextEditingController();
  final txtCodeMarca = TextEditingController();
  final txtCodeCategoria = TextEditingController();
  final txtModelo = TextEditingController();
  final txtDetalle = TextEditingController();
  final txtPrecio = TextEditingController();
  final txtStock = TextEditingController();
  final txtImagePath = TextEditingController();

  @override
  void initState() {
    super.initState();
    consultaCategorias();
    consultaMarcas();
    //this.vista = "Seleccione su departamento";
  }

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
                            "Mantenimiento Componentes",
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
                            texto: "Buscar por Codigo",
                            tIcon: Icons.search,
                          ),
                          SizedBox(width: 15),
                          BotonRectangular(
                            w: 100,
                            texto: "Buscar",
                            ejecutar: () {
                              setState(() {
                                Search();
                                print("oh");
                              });
                            },
                          )
                        ],
                      ),
                      TextFieldPersonal(
                        w: 350,
                        validacion: null,
                        controlador: txtCodigo,
                        texto: "Codigo",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      DropDownPersonal(
                        w: 350,
                        viewDefault: marca,
                        listado: listMarcas,
                        onChange: (valor) {
                          setState(() {
                            marca = valor.toString();
                          });
                        },
                      ),
                      DropDownPersonal(
                        w: 350,
                        viewDefault: categoria,
                        listado: listCategorias,
                        onChange: (valor) {
                          setState(() {
                            categoria = valor.toString();
                          });
                        },
                      ),
                      TextFieldPersonal(
                        w: 350,
                        validacion: null,
                        controlador: txtModelo,
                        texto: "Modelo",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        h: 150,
                        w: 350,
                        validacion: null,
                        controlador: txtDetalle,
                        texto: "Detalle",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        w: 350,
                        validacion: null,
                        controlador: txtPrecio,
                        texto: "Precio",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        w: 350,
                        validacion: null,
                        controlador: txtStock,
                        texto: "Stock",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      TextFieldPersonal(
                        w: 350,
                        h: 150,
                        validacion: null,
                        controlador: txtImagePath,
                        texto: "URL Imagen",
                        tIcon: Icons.arrow_right_outlined,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 200,
                            child: imagen == null
                                ? Text("Subir Imagen")
                                : Image.file(
                                    imagen,
                                    width: 150,
                                    height: 150,
                                  ),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.image),
                            onPressed: () async {
                              await getImage();
                            },
                          ),
                        ],
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
                              print(marca);
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

  Future<void> getImage() async {
    var temImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      imagen = File(temImage!.path);
      print(temImage.path);
    });

    FirebaseStorage ds = FirebaseStorage.instance;
    NumberFormat formatter = NumberFormat("00000");
    var lisresult = await ds.ref().listAll();
    var ddass = lisresult.items.length;
    print(ddass);
    List listado = [];
    for (int i = 0; i < lisresult.items.length; i++) {
      listado.add(lisresult.items[i].name);
    }
    listado.sort();
    var codigo = listado.last;

    String code = codigo.toString();
    code = "IC${formatter.format(int.parse(code.substring(2, 7)) + 1)}.jpg";
    print(code);
    await ds.ref(code).putFile(imagen);

    var pathImage = await ds.ref(code).getDownloadURL();
    print(pathImage);
    txtImagePath.text = pathImage;
  }

  Future<void> PRUEBA() async {
    if (txtCodigo.text != null && txtCodigo.text != "") {
      eMarcas em = eMarcas();
      //var codeMarca = await em.getCodeE(marca);

    } else {
      print("Error");
    }
  }

  Future<void> actualizar() async {
    if (txtCodigo.text != null && txtCodigo.text != "") {
      eMarcas em = eMarcas();
      var codeMarca = await em.getCodeE(marca);

      eCategorias ec = eCategorias();
      var codeCategoria = await ec.getCodeE(categoria);

      var stock = int.parse(txtStock.text
          .split('')
          .reversed
          .join()
          .substring(4)
          .split('')
          .reversed
          .join());
      var precio = double.parse(txtPrecio.text.substring(4));

      eComponents eco = eComponents();
      await eco.actualizarE(
          txtCodigo.text,
          codeCategoria,
          codeMarca,
          txtModelo.text,
          txtDetalle.text,
          "Activo",
          txtImagePath.text,
          stock,
          precio);
    } else {
      print("Error");
    }
  }

  Future<void> registrar() async {
    eMarcas em = eMarcas();
    var codeMarca = await em.getCodeE(marca);

    eCategorias ec = eCategorias();
    var codeCategoria = await ec.getCodeE(categoria);

    var stock = int.parse(txtStock.text
        .split('')
        .reversed
        .join()
        .substring(4)
        .split('')
        .reversed
        .join());
    var precio = double.parse(txtPrecio.text.substring(4));

    eComponents eco = eComponents();
    await eco.registrarE(
        txtCodigo.text,
        codeCategoria,
        codeMarca,
        txtModelo.text,
        txtDetalle.text,
        "Activo",
        txtImagePath.text,
        stock,
        precio);
  }

  Future<void> eliminar() async {
    if (txtCodigo.text != null && txtCodigo.text != "") {
      eComponents eco = eComponents();
      await eco.eliminarE(txtCodigo.text);
    } else {
      print("Error");
    }
  }

  Future<void> Search() async {
    if (txtSearch.text != null && txtSearch.text != "") {
      eComponents ec = eComponents();
      var componente = await ec.getComponentbyCodeE(txtSearch.text);
      eCategorias eca = eCategorias();
      var categoriaDB = await eca.getCategoriaE(componente.cod_categoria);

      eMarcas ema = eMarcas();
      var marcaDB = await ema.getMarcasE(componente.cod_marca);

      txtCodigo.text = componente.codigo;
      setState(() {
        marca = marcaDB;
        categoria = categoriaDB;
      });

      txtModelo.text = componente.modelo;
      txtDetalle.text = componente.detalle;
      txtPrecio.text = "S/. ${componente.precio.toString()}";
      txtStock.text = "${componente.stock.toString()} un.";
      txtImagePath.text = componente.imagen_path;
    } else {
      print("Error");
    }
  }

  void consultaCategorias() async {
    eCategorias ec = eCategorias();
    var valor = await ec.getListCategoriasE();
    setState(() {
      listCategorias = valor;
      categoria = "Categorias";
    });
  }

  void consultaMarcas() async {
    eMarcas em = eMarcas();
    var valor = await em.getListMarcasE();
    setState(() {
      listMarcas = valor;
      marca = "Marcas";
    });
  }
}
