class AmbienteModel {
  int id;
  String nombre;
  int aforo;

  AmbienteModel({this.id = 0, this.nombre = "", this.aforo = 0});

  factory AmbienteModel.fromJson(Map<String, dynamic> json) => AmbienteModel(
        id: int.parse(json["id"]),
        nombre: json["nombre"],
        aforo: int.parse(json["aforo_total"]),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "aforo": aforo,
      };

  AmbienteModel copy() => AmbienteModel(
        id: this.id,
        nombre: this.nombre,
        aforo: this.aforo,
      );
}
