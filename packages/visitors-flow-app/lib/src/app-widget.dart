// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart';
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
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ThemeHelper().colorScheme(),
      ),
      navigatorObservers: [
        Asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      builder: Asuka.builder,
    ).modular();
  }
}
