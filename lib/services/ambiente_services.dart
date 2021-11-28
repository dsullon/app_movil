import 'package:flutter/cupertino.dart';
import 'package:reservas/models/ambiente_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AmbienteServices extends ChangeNotifier {
  final String baseUrl = "10.0.2.2";
  final String recurso = "curso_movil/api/public/ambientes";
  final List<AmbienteModel> ambientes = [];
  late AmbienteModel ambienteSeleccionado;

  bool cargando = true;

  AmbienteServices() {
    obtenerAmbientes();
  }

  obtenerAmbientes() async {
    this.cargando = true;
    final url = Uri.http(
        baseUrl, recurso); // http://10.0.2.2/curso_movil/api/public/usuarios
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodeResponse = jsonDecode(response.body);
      final data = decodeResponse['data'] as List;
      final dataAux = data.map((item) => AmbienteModel.fromJson(item)).toList();
      this.ambientes.addAll(dataAux);
      this.cargando = false;
      notifyListeners();
    }
  }

  guardarCambios(AmbienteModel ambiente) async {
    if (ambiente.id > 0) {
      await actualizarAmbiente(ambiente);
    } else {
      await crearAmbiente(ambiente);
    }
    notifyListeners();
  }

  crearAmbiente(AmbienteModel ambiente) async {
    final url = Uri.http(baseUrl, recurso);
    final resp = await http.post(url, body: json.encode(ambiente.toMap()));
    if (resp.statusCode == 200) {
      final decodeResponse = jsonDecode(resp.body);
      final data = decodeResponse['data'];
      final ambiente = AmbienteModel.fromJson(data);
      ambientes.add(ambiente);
    }
  }

  actualizarAmbiente(AmbienteModel ambiente) async {
    final url = Uri.http(baseUrl, "${recurso}/${ambiente.id}");
    final resp = await http.put(url, body: jsonEncode(ambiente.toMap()));
    if (resp.statusCode == 200) {
      final decodeResponse = jsonDecode(resp.body);
      final data = decodeResponse['data'];
      final ambiente = AmbienteModel.fromJson(data);
      final index =
          ambientes.indexWhere((ambienteAux) => ambienteAux.id == ambiente.id);
      ambientes[index] = ambiente;
    } else {
      print("NO se ha actualizado los datos");
    }
  }

  eliminarAmbiente(AmbienteModel ambiente) async {
    final url = Uri.http(baseUrl, "${recurso}/${ambiente.id}");
    final resp = await http.delete(url);
    if (resp.statusCode == 200) {
      ambientes.removeWhere((ambienteAux) => ambienteAux.id == ambiente.id);
    }
    notifyListeners();
  }
}
