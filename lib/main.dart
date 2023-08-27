import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taggy/screens/main_screen.dart';
import 'package:taggy/storage.dart';
import 'package:taggy/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Taggy());

class Taggy extends StatelessWidget {
  const Taggy({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GalleryStorageSQLite.create(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Provider.value(
                value: snapshot.data!,
                child: MaterialApp(
                    builder: ((context, child) => MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(accessibleNavigation: false),
                        child: child!)),
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
                    home: const MainScreen()));
          } else {
            return const SizedBox.shrink();
          }
        }));
  }
}
