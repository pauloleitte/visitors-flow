import 'package:flutter/material.dart';

import 'app-constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: white,
    primarySwatch: white,
    fontFamily: 'Muli',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    snackBarTheme: snackBarThemeData(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: textSelectionThemeData(),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );

  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(
        color: kSecondaryColor, style: BorderStyle.solid, width: 2.0),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.all(25),
    enabledBorder: enabledBorder,
    focusedBorder: focusedBorder,
    border: enabledBorder,
  );
}

TextSelectionThemeData textSelectionThemeData() {
  return TextSelectionThemeData(
    cursorColor: kSecondaryColor,
    selectionColor: kSecondaryColor,
    selectionHandleColor: kSecondaryColor,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

SnackBarThemeData snackBarThemeData() {
  return SnackBarThemeData(backgroundColor: kPrimaryColor);
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kSecondaryColor,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
