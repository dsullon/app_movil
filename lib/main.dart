import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservas/pages/ambiente_form_page.dart';
import 'package:reservas/pages/ambientes_page.dart';
import 'package:reservas/services/ambiente_services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AmbienteServices(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => AmbientesPage(),
        "editar_ambiente": (BuildContext context) => AmbienteFormPage()
      },
    );
  }
}
