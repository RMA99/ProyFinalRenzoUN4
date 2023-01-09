import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proy_final_renzo/application/widgets/Unit_Settings.dart';
import 'package:proy_final_renzo/infrastructure/providers/theme.dart';

class FrmSettings extends StatelessWidget {
  FrmSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Configuración"),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                UnitSettings(
                  texto: "Modo Oscuro",
                  interaction: Switch(
                    value: themeProvider.isDark,
                    onChanged: (value) {
                      themeProvider.isDark = value;
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
