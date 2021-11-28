import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservas/models/ambiente_model.dart';
import 'package:reservas/services/ambiente_services.dart';
import 'package:reservas/widgets/ambiente_list_widget.dart';

class AmbientesPage extends StatelessWidget {
  List<AmbienteModel> _listaAmbientes = [];

  @override
  Widget build(BuildContext context) {
    final ambienteProvider = Provider.of<AmbienteServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de ambientes"),
      ),
      body: Container(
        child: AmbienteListWidget(
          listaAmbientes: ambienteProvider.ambientes,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          ambienteProvider.ambienteSeleccionado = AmbienteModel();
          Navigator.pushNamed(context, "editar_ambiente");
        },
      ),
    );
  }
}
