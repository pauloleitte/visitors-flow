import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeHelper {
  final primaryColor = const MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
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
    Color c2 = Theme.of(context).colorScheme.secondary;
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

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size.fromRadius(10)),
      backgroundColor: MaterialStateProperty.all(HexColor('#000000')),
    );
  }

  IconThemeData iconThemeData() {
    return const IconThemeData(
      color: Colors.white,
    );
  }

  SnackBarThemeData snackBarThemeData() {
    return const SnackBarThemeData(
        elevation: 2,
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(
          color: Colors.black,
        ));
  }

  ButtonThemeData buttonThemeData() {
    return ButtonThemeData(
        disabledColor: Colors.grey.shade400,
        buttonColor: HexColor('#000000'),
        textTheme: ButtonTextTheme.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ));
  }

  ColorScheme colorScheme() {
    return ColorScheme.fromSwatch(
      primarySwatch: primaryColor,
      accentColor: HexColor('#FFFFFF'),
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
