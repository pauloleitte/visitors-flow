// ignore_for_file: file_names

import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:visitors_flow_app/src/core/config/app_constants.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = HexColor(AppConstants.PRIMARY_COLOR);
    Color scaffoldBackgroundColor =
        HexColor(AppConstants.SCAFFOLD_BACKGROUND_COLOR);
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
        floatingActionButtonTheme:
            ThemeHelper().floatingActionButtonThemeData(),
        appBarTheme: ThemeHelper().appBarTheme(),
        snackBarTheme: ThemeHelper().snackBarThemeData(),
        fontFamily: 'Oxygen',
        iconTheme: ThemeHelper().iconThemeData(),
        buttonTheme: ThemeHelper().buttonThemeData(),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        colorScheme: ThemeHelper().colorScheme(),
      ),
      navigatorObservers: [Asuka.asukaHeroController],
      builder: Asuka.builder,
    ).modular();
  }
}
