import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservas/services/ambiente_services.dart';

class AmbienteFormPage extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ambienteProvider = Provider.of<AmbienteServices>(context);
    final ambiente = ambienteProvider.ambienteSeleccionado;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ambientes"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: ambiente.nombre,
              onChanged: (value) => ambiente.nombre = value,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              initialValue: ambiente.aforo.toString(),
              onChanged: (value) => ambiente.aforo = int.parse(value),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ambienteProvider.guardarCambios(ambiente);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
