import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservas/models/ambiente_model.dart';
import 'package:reservas/pages/ambiente_form_page.dart';
import 'package:reservas/services/ambiente_services.dart';
import 'package:reservas/widgets/loading_widget.dart';

class AmbienteListWidget extends StatelessWidget {
  List<AmbienteModel> listaAmbientes = [];

  AmbienteListWidget({Key? key, required this.listaAmbientes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ambienteProvider = Provider.of<AmbienteServices>(context);
    if (ambienteProvider.cargando) return LoadingWidget();
    return ListView.builder(
        itemCount: listaAmbientes.length,
        itemBuilder: (context, index) {
          final ambiente = listaAmbientes[index];
          return ListTile(
            title: Text(ambiente.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aforo ${ambiente.aforo}"),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        ambienteProvider.ambienteSeleccionado = ambiente.copy();
                        Navigator.pushNamed(context, "editar_ambiente");
                      },
                      child: Row(
                        children: [Icon(Icons.edit), Text("Editar")],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ambienteProvider.eliminarAmbiente(ambiente);
                      },
                      child: Row(
                        children: [Icon(Icons.delete), Text("Eliminar")],
                      ),
                    ),
                  ],
                )
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.green,
            ),
          );
        });
  }
}
