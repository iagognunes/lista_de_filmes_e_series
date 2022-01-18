import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_filmes_e_series/view/login/view/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Séries/Filmes',
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
