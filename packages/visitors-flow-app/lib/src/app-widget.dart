// ignore: file_names
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hexcolor/hexcolor.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = HexColor('#344955');
    Color accentColor = HexColor('#F9AA33');
    return MaterialApp(
      title: 'Visitors Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: accentColor),
      ),
      navigatorObservers: [
        asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      builder: asuka.builder,
    ).modular();
  }
}
