import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taggy/main_screen.dart';
import 'package:taggy/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const Taggy());

class Taggy extends StatelessWidget {
  const Taggy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taggy',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
