import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = HexColor('#000000');
    return MaterialApp(
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'AD Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        snackBarTheme: ThemeHelper().snackBarThemeData(),
        fontFamily: 'Oxygen',
        iconTheme: ThemeHelper().iconThemeData(),
        buttonTheme: ThemeHelper().buttonThemeData(),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ThemeHelper().colorScheme(),
      ),
      navigatorObservers: [
        asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      builder: asuka.builder,
    ).modular();
  }
}
