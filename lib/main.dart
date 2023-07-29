import 'package:flutter/material.dart';
import 'package:taggy/main_screen.dart';
import 'package:taggy/utils.dart';
// import 'package:taggy/page-1/tela-arquivos.dart';
// import 'package:taggy/page-1/tela-arquivos-do-celular.dart';
// import 'package:taggy/page-1/tela-principal.dart';
// import 'package:taggy/page-1/tela-resultado-busca.dart';
// import 'package:taggy/page-1/tela-inicial.dart';
// import 'package:taggy/page-1/tela-busca.dart';
// import 'package:taggy/page-1/tela-detalhe-imagem.dart';
// import 'package:taggy/page-1/popup-menu.dart';
// import 'package:taggy/page-1/popup-arquivo.dart';

void main() => runApp(const Taggy());

class Taggy extends StatelessWidget {
  const Taggy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
