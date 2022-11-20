import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'app_constants.dart';

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = "", Icon? icon]) {
    return InputDecoration(
      prefixIcon: icon,
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor(AppConstants.PRIMARY_COLOR))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor(AppConstants.PRIMARY_COLOR))),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actionsIconTheme:
            IconThemeData(color: HexColor(AppConstants.SECONDARY_COLOR)),
        iconTheme: IconThemeData(color: HexColor(AppConstants.SECONDARY_COLOR)),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: HexColor(AppConstants.PRIMARY_COLOR),
        ));
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(
    BuildContext context,
  ) {
    Color c1 = Theme.of(context).primaryColor;
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: c1.withOpacity(0.1),
          blurRadius: 18,
          offset: const Offset(10, 10),
        ),
      ],
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle(BuildContext context) {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size.fromRadius(10)),
      backgroundColor:
          MaterialStateProperty.all(Theme.of(context).primaryColor),
    );
  }

  TextStyle buttonTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary);
  }

  FloatingActionButtonThemeData floatingActionButtonThemeData() {
    return FloatingActionButtonThemeData(
        backgroundColor: HexColor(AppConstants.PRIMARY_COLOR),
        foregroundColor: HexColor(AppConstants.SECONDARY_COLOR));
  }

  IconThemeData iconThemeData() {
    return IconThemeData(
      color: HexColor(AppConstants.SECONDARY_COLOR),
    );
  }

  SnackBarThemeData snackBarThemeData() {
    return SnackBarThemeData(
        elevation: 2,
        backgroundColor: HexColor(AppConstants.SECONDARY_COLOR),
        contentTextStyle: TextStyle(
            color: HexColor(AppConstants.PRIMARY_COLOR),
            fontWeight: FontWeight.bold));
  }

  ButtonThemeData buttonThemeData() {
    return ButtonThemeData(
        disabledColor: Colors.grey.shade400,
        buttonColor: HexColor(AppConstants.PRIMARY_COLOR),
        textTheme: ButtonTextTheme.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ));
  }

  ColorScheme colorScheme() {
    return ColorScheme.fromSwatch(
      primarySwatch: AppConstants.PRIMARY_COLOR_SWATCH,
      accentColor: HexColor(AppConstants.SECONDARY_COLOR),
      errorColor: Colors.red,
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
