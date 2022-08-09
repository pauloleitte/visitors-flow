// ignore: file_names
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = HexColor('#173D70');
    return MaterialApp(
      title: 'Visitors Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
