import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proy_final_renzo/application/use_cases/frmlogin.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';
import 'package:provider/provider.dart';

class Portada extends StatelessWidget {
  const Portada({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeProvider, bool>((bloc) => bloc.isDark);
    return GestureDetector(
      onTap: () {
        print("GOD");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FrmLogin(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.jpg"),
            invertColors: isDark,
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "R-STORE",
                  style: TextStyle(
                      fontFamily: "BodoniModa",
                      fontSize: 60,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                //Image.asset("assets/images/logo_oscuro.png"),
                SizedBox(
                  height: 50,
                ),
                Image.asset("assets/images/logo.png", width: 150),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Comenzar",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
