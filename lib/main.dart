import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/infrastructure/providers/prevListCarrito.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:proy_final_renzo/application/use_cases/Portada.dart';
import 'package:proy_final_renzo/infrastructure/controllers/cUsuarios.dart';
import 'package:proy_final_renzo/infrastructure/entitymanager/eusuarios.dart';
import 'infrastructure/controllers/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PrevListCarritoProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  eUsuarios eu = eUsuarios();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    return MaterialApp(
      //theme: ThemeData(fontFamily: "NotoNastaliqUrdu"),
      //theme: ThemeData.dark(),
      theme: isDark
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.green,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Color.fromARGB(255, 70, 70, 70),
                secondary: Color.fromARGB(255, 33, 243, 180),
              ),
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.green,
              /*appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),*/
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Color.fromARGB(255, 82, 116, 131),
                secondary: Color.fromARGB(255, 27, 85, 95),
              ),
            ),
      debugShowCheckedModeBanner: false,
      home: Portada(),
    );
  }
}
/*
class Prueba extends StatelessWidget {
  const Prueba({
    Key? key,
    required this.eu,
  }) : super(key: key);

  final eUsuarios eu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proy"),
      ),
      body: FutureBuilder(
        future: getpersonas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data[index]["codigo"]);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var ds = await eu.isUserE("Renzo", "123");
          print(ds);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
*/