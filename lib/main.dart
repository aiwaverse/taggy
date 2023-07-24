import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/tela_tags.dart';
// import 'package:myapp/page-1/tela-arquivos.dart';
// import 'package:myapp/page-1/tela-arquivos-do-celular.dart';
// import 'package:myapp/page-1/tela-principal.dart';
// import 'package:myapp/page-1/tela-resultado-busca.dart';
// import 'package:myapp/page-1/tela-inicial.dart';
// import 'package:myapp/page-1/tela-busca.dart';
// import 'package:myapp/page-1/tela-detalhe-imagem.dart';
// import 'package:myapp/page-1/popup-menu.dart';
// import 'package:myapp/page-1/popup-arquivo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: Scene(),
        ),
      ),
    );
  }
}
